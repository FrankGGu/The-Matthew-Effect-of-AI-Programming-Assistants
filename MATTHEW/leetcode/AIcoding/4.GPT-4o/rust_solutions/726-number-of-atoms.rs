use std::collections::HashMap;

pub fn count_of_atoms(formula: String) -> String {
    let mut stack: Vec<HashMap<String, i32>> = vec![HashMap::new()];
    let mut i = 0;
    let n = formula.len();

    while i < n {
        if formula.as_bytes()[i] == b'(' {
            stack.push(HashMap::new());
            i += 1;
        } else if formula.as_bytes()[i] == b')' {
            let mut num = 0;
            i += 1;
            while i < n && formula.as_bytes()[i].is_ascii_digit() {
                num = num * 10 + (formula.as_bytes()[i] - b'0') as i32;
                i += 1;
            }
            let last_map = stack.pop().unwrap();
            let multiplier = if num == 0 { 1 } else { num };
            for (atom, count) in last_map {
                *stack.last_mut().unwrap().entry(atom).or_insert(0) += count * multiplier;
            }
        } else {
            let mut atom = String::new();
            atom.push(formula.as_bytes()[i] as char);
            i += 1;
            while i < n && formula.as_bytes()[i].is_ascii_lowercase() {
                atom.push(formula.as_bytes()[i] as char);
                i += 1;
            }
            let mut num = 0;
            while i < n && formula.as_bytes()[i].is_ascii_digit() {
                num = num * 10 + (formula.as_bytes()[i] - b'0') as i32;
                i += 1;
            }
            let count = if num == 0 { 1 } else { num };
            *stack.last_mut().unwrap().entry(atom).or_insert(0) += count;
        }
    }

    let mut result = String::new();
    let mut atoms: Vec<_> = stack.pop().unwrap().iter().collect();
    atoms.sort_by(|a, b| a.0.cmp(b.0));
    for (atom, count) in atoms {
        result.push_str(atom);
        if *count > 1 {
            result.push_str(&count.to_string());
        }
    }
    result
}