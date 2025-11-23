impl Solution {
    pub fn min_remove_to_make_valid(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut stack: Vec<usize> = Vec::new();

        // First pass: Identify and mark invalid closing parentheses
        // An invalid ')' is one that does not have a matching open '(' before it.
        for i in 0..chars.len() {
            match chars[i] {
                '(' => {
                    stack.push(i);
                }
                ')' => {
                    if let Some(_) = stack.pop() {
                        // Found a matching '(' for this ')'
                    } else {
                        // No matching '(' found, this ')' is invalid. Mark it for removal.
                        chars[i] = '*';
                    }
                }
                _ => {
                    // Do nothing for lowercase English letters
                }
            }
        }

        // Second pass: Identify and mark unmatched opening parentheses
        // Any remaining indices in the stack correspond to unmatched '('
        for i in stack {
            chars[i] = '*';
        }

        // Build the final string, excluding characters marked for removal ('*')
        chars.into_iter().filter(|&c| c != '*').collect()
    }
}