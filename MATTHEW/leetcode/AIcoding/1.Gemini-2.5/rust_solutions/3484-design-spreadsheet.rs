use std::collections::{HashMap, HashSet};
use std::iter::Peekable;
use std::str::Chars;

#[derive(Debug, Clone)]
enum CellContent {
    Value(i32),
    Formula(Vec<Token>),
}

#[derive(Debug, Clone)]
enum Token {
    Number(i32),
    Op(char), // '+', '-', '*', '/'
    CellRef(usize, usize), // (row_idx, col_idx)
    SumRange(usize, usize, usize, usize), // (start_row, start_col, end_row, end_col)
}

#[derive(Debug, Clone)]
struct Cell {
    expression: String,
    content: CellContent,
    value: i32,
    needs_recompute: bool,
    dependencies: HashSet<(usize, usize)>, // Cells this cell depends on
}

impl Cell {
    fn new(expr: String) -> Self {
        Cell {
            expression: expr,
            content: CellContent::Value(0), // Placeholder, will be parsed
            value: 0,
            needs_recompute: true, // Always needs recompute initially
            dependencies: HashSet::new(),
        }
    }
}

struct Spreadsheet {
    cells: Vec<Vec<Cell>>, // 26 rows, 9 columns
    // dependents_map: Key: dependency (r,c), Value: cells that depend on it
    dependents_map: HashMap<(usize, usize), HashSet<(usize, usize)>>,
}

fn char_to_row_idx(c: char) -> usize {
    (c as u8 - b'A') as usize
}

fn digit_to_col_idx(d: char) -> usize {
    (d as u8 - b'1') as usize
}

fn parse_cell_ref(s: &str) -> (usize, usize) {
    let row_char = s.chars().next().unwrap();
    let col_char = s.chars().nth(1).unwrap();
    (char_to_row_idx(row_char), digit_to_col_idx(col_char))
}

impl Spreadsheet {
    const ROWS: usize = 26;
    const COLS: usize = 9;

    fn new() -> Self {
        let mut cells = Vec::with_capacity(Self::ROWS);
        for _ in 0..Self::ROWS {
            let mut row_vec = Vec::with_capacity(Self::COLS);
            for _ in 0..Self::COLS {
                row_vec.push(Cell::new("0".to_string())); // Initialize with "0"
            }
            cells.push(row_vec);
        }

        let mut spreadsheet = Spreadsheet {
            cells,
            dependents_map: HashMap::new(),
        };

        // Initialize all cells by calling update with their default "0" expression
        // to correctly set their initial content and needs_recompute flags.
        for r in 0..Self::ROWS {
            for c in 0..Self::COLS {
                let (content, dependencies) = spreadsheet.parse_expression("0");
                spreadsheet.cells[r][c].content = content;
                spreadsheet.cells[r][c].dependencies = dependencies;
                spreadsheet.cells[r][c].needs_recompute = true; // Mark as needing recompute
            }
        }

        spreadsheet
    }

    fn update(&mut self, row: i32, col: i32, expression: String) {
        let r_idx = (row - 1) as usize;
        let c_idx = (col - 1) as usize;

        // 1. Clear old dependencies from `dependents_map`
        let old_dependencies = self.cells[r_idx][c_idx].dependencies.clone();
        for (dr, dc) in old_dependencies.iter() {
            if let Some(dependents) = self.dependents_map.get_mut(&(*dr, *dc)) {
                dependents.remove(&(r_idx, c_idx));
            }
        }

        // 2. Parse new expression and update cell's content and dependencies
        let (new_content, new_dependencies_set) = self.parse_expression(&expression);

        self.cells[r_idx][c_idx].expression = expression;
        self.cells[r_idx][c_idx].content = new_content;
        self.cells[r_idx][c_idx].dependencies = new_dependencies_set.clone(); // Store new dependencies
        self.cells[r_idx][c_idx].needs_recompute = true; // Mark as needing recompute

        // 3. Update `dependents_map` with new dependencies
        for (dr, dc) in new_dependencies_set.iter() {
            self.dependents_map.entry((*dr, *dc))
                .or_insert_with(HashSet::new)
                .insert((r_idx, c_idx));
        }

        // 4. Invalidate this cell and all its dependents
        self.invalidate_cell(r_idx, c_idx);
    }

    fn get(&mut self, row: i32, col: i32) -> i32 {
        let r_idx = (row - 1) as usize;
        let c_idx = (col - 1) as usize;

        let mut visiting_stack = HashSet::new();
        self.evaluate_cell(r_idx, c_idx, &mut visiting_stack)
    }

    // Helper to parse expression and extract dependencies
    // Returns (CellContent, HashSet<(r,c)> of dependencies)
    fn parse_expression(&self, expression: &str) -> (CellContent, HashSet<(usize, usize)>) {
        let mut dependencies = HashSet::new();

        if !expression.starts_with('=') {
            // It's a simple value
            let value = expression.parse::<i32>().unwrap_or(0);
            return (CellContent::Value(value), dependencies);
        }

        // It's a formula
        let formula_str = &expression[1..];
        let mut tokens = Vec::new();
        let mut chars: Peekable<Chars> = formula_str.chars().peekable();

        while let Some(&c) = chars.peek() {
            if c.is_whitespace() {
                chars.next();
                continue;
            }

            if c.is_ascii_digit() {
                let mut num_str = String::new();
                while let Some(&d) = chars.peek() {
                    if d.is_ascii_digit() {
                        num_str.push(chars.next().unwrap());
                    } else {
                        break;
                    }
                }
                tokens.push(Token::Number(num_str.parse().unwrap_or(0)));
            } else if c == '-' && (tokens.is_empty() || matches!(tokens.last(), Some(Token::Op(_)))) {
                // Potential negative number literal. Look ahead.
                let mut temp_chars = chars.clone();
                temp_chars.next(); // Consume '-'
                if let Some(next_char) = temp_chars.peek() {
                    if next_char.is_ascii_digit() {
                        // It's a negative number literal
                        let mut num_str = String::new();
                        num_str.push(chars.next().unwrap()); // Consume '-'
                        while let Some(&d) = chars.peek() {
                            if d.is_ascii_digit() {
                                num_str.push(chars.next().unwrap());
                            } else {
                                break;
                            }
                        }
                        tokens.push(Token::Number(num_str.parse().unwrap_or(0)));
                    } else {
                        // It's a binary operator, or a unary minus followed by non-digit (e.g., cell ref)
                        // The evaluation logic will handle "0 - X" for unary minus.
                        tokens.push(Token::Op(chars.next().unwrap()));
                    }
                } else { // '-' is the last char, treat as operator (will cause issues if not followed by operand)
                    tokens.push(Token::Op(chars.next().unwrap()));
                }
            } else if c == '+' || c == '*' || c == '/' {
                tokens.push(Token::Op(chars.next().unwrap()));
            } else if c.is_ascii_alphabetic() { // Cell reference or SUM
                let mut cell_ref_or_sum_str = String::new();
                while let Some(&d) = chars.peek() {
                    if d.is_ascii_alphanumeric() {
                        cell_ref_or_sum_str.push(chars.next().unwrap());
                    } else {
                        break;
                    }
                }

                if cell_ref_or_sum_str.starts_with("SUM") {
                    chars.next(); // Consume '('
                    let mut range_str = String::new();
                    while let Some(&d) = chars.peek() {
                        if d != ')' {
                            range_str.push(chars.next().unwrap());
                        } else {
                            break;
                        }
                    }
                    chars.next(); // Consume ')'

                    let parts: Vec<&str> = range_str.split(':').collect();
                    let (sr, sc) = parse_cell_ref(parts[0]);
                    let (er, ec) = parse_cell_ref(parts[1]);
                    tokens.push(Token::SumRange(sr, sc, er, ec));
                    for r_dep in sr..=er {
                        for c_dep in sc..=ec {
                            dependencies.insert((r_dep, c_dep));
                        }
                    }
                } else {
                    // Standard cell reference A1, B2
                    let (r_dep, c_dep) = parse_cell_ref(&cell_ref_or_sum_str);
                    tokens.push(Token::CellRef(r_dep, c_dep));
                    dependencies.insert((r_dep, c_dep));
                }
            } else {
                chars.next(); // Skip any other unexpected characters
            }
        }

        (CellContent::Formula(tokens), dependencies)
    }

    // Helper to invalidate a cell and its dependents
    fn invalidate_cell(&mut self, r_idx: usize, c_idx: usize) {
        let mut queue = vec![(r_idx, c_idx)];
        let mut visited = HashSet::new();
        visited.insert((r_idx, c_idx));

        while let Some((curr_r, curr_c)) = queue.pop() {
            self.cells[curr_r][curr_c].needs_recompute = true;

            if let Some(dependents) = self.dependents_map.get(&(curr_r, curr_c)) {
                // Iterate over a cloned set to avoid mutable borrow issues while modifying `queue`
                for &(dep_r, dep_c) in dependents.clone().iter() {
                    if visited.insert((dep_r, dep_c)) {
                        queue.push((dep_r, dep_c));
                    }
                }
            }
        }
    }

    // Helper to evaluate a cell using DFS with memoization and cycle detection
    fn evaluate_cell(&mut self, r_idx: usize, c_idx: usize, visiting_stack: &mut HashSet<(usize, usize)>) -> i32 {
        // Cycle detection
        if !visiting_stack.insert((r_idx, c_idx)) {
            // Circular dependency detected
            return 0;
        }

        // Memoization
        if !self.cells[r_idx][c_idx].needs_recompute {
            visiting_stack.remove(&(r_idx, c_idx));
            return self.cells[r_idx][c_idx].value;
        }

        let result = match &self.cells[r_idx][c_idx].content.clone() { // Clone to avoid mutable borrow issues
            CellContent::Value(val) => *val,
            CellContent::Formula(tokens) => {
                let mut evaluated_tokens: Vec<Token> = Vec::new();
                for token in tokens {
                    match token {
                        Token::Number(n) => evaluated_tokens.push(Token::Number(*n)),
                        Token::Op(op) => evaluated_tokens.push(Token::Op(*op)),
                        Token::CellRef(dr, dc) => {
                            let val = self.evaluate_cell(*dr, *dc, visiting_stack);
                            evaluated_tokens.push(Token::Number(val));
                        }
                        Token::SumRange(sr, sc, er, ec) => {
                            let mut sum = 0;
                            for r_loop in *sr..=*er {
                                for c_loop in *sc..=*ec {
                                    sum += self.evaluate_cell(r_loop, c_loop, visiting_stack);
                                }
                            }
                            evaluated_tokens.push(Token::Number(sum));
                        }
                    }
                }

                // Now evaluate the arithmetic expression from `evaluated_tokens`
                // Using a two-stack (values, ops) approach for infix evaluation.
                let mut values: Vec<i32> = Vec::new();
                let mut ops: Vec<char> = Vec::new();

                for token in evaluated_tokens {
                    match token {
                        Token::Number(n) => values.push(n),
                        Token::Op(op) => {
                            // Apply operators with higher or equal precedence
                            while let Some(&last_op) = ops.last() {
                                if Self::precedence(last_op) >= Self::precedence(op) {
                                    let val2 = values.pop().unwrap_or(0);
                                    let val1 = values.pop().unwrap_or(0); // Handles unary minus if values is empty
                                    let op_char = ops.pop().unwrap();
                                    values.push(Self::apply_op(val1, val2, op_char));
                                } else {
                                    break;
                                }
                            }
                            ops.push(op);
                        }
                        _ => unreachable!(), // Should only have numbers and ops here after pre-evaluation
                    }
                }

                // Apply remaining operators
                while let Some(op_char) = ops.pop() {
                    let val2 = values.pop().unwrap_or(0);
                    let val1 = values.pop().unwrap_or(0); // Handles unary minus if values is empty
                    values.push(Self::apply_op(val1, val2, op_char));
                }
                values.pop().unwrap_or(0)
            }
        };

        self.cells[r_idx][c_idx].value = result;
        self.cells[r_idx][c_idx].needs_recompute = false;
        visiting_stack.remove(&(r_idx, c_idx));
        result
    }

    fn precedence(op: char) -> i32 {
        match op {
            '+' | '-' => 1,
            '*' | '/' => 2,
            _ => 0, // Should not happen for valid operators
        }
    }

    fn apply_op(a: i32, b: i32, op: char) -> i32 {
        match op {
            '+' => a + b,
            '-' => a - b,
            '*' => a * b,
            '/' => {
                if b == 0 { 0 } else { a / b }
            }
            _ => 0, // Should not happen
        }
    }
}