struct Solution;

impl Solution {
    fn parse_recursive(chars: &[char], i: &mut usize) -> bool {
        let op = chars[*i];
        *i += 1; // Move past the current character (operator or literal)

        if op == 't' {
            return true;
        }
        if op == 'f' {
            return false;
        }

        // If not 't' or 'f', it must be an operator: '&', '|', '!'
        *i += 1; // Move past '('

        let mut res = match op {
            '&' => true,  // Initial value for AND operation
            '|' => false, // Initial value for OR operation
            '!' => false, // Initial value for NOT, actual value is determined by the single sub-expression
            _ => unreachable!(), // Should not happen based on problem constraints
        };

        if op == '!' {
            // For '!', there's only one sub-expression
            res = Self::parse_recursive(chars, i);
        } else {
            // For '&' and '|', there can be multiple comma-separated sub-expressions
            loop {
                let current_val = Self::parse_recursive(chars, i);
                match op {
                    '&' => res = res && current_val,
                    '|' => res = res || current_val,
                    _ => unreachable!(),
                }

                if chars[*i] == ')' {
                    break; // End of current operator's arguments
                }
                *i += 1; // Move past ',' to the next sub-expression
            }
        }

        *i += 1; // Move past ')'

        if op == '!' {
            !res // Apply negation for '!' operator
        } else {
            res
        }
    }

    pub fn parse_bool_expr(expression: String) -> bool {
        let chars: Vec<char> = expression.chars().collect();
        let mut i = 0; // Current index in the character array
        Self::parse_recursive(&chars, &mut i)
    }
}