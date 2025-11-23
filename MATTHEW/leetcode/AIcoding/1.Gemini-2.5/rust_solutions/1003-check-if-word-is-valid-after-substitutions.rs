impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack: Vec<char> = Vec::new();

        for c in s.chars() {
            match c {
                'a' => {
                    stack.push('a');
                }
                'b' => {
                    stack.push('b');
                }
                'c' => {
                    if stack.len() < 2 {
                        return false; // Not enough elements for 'ab'
                    }
                    let top = stack.pop().unwrap(); // Safe due to len check
                    let second_top = stack.pop().unwrap(); // Safe due to len check

                    if top != 'b' || second_top != 'a' {
                        return false; // Mismatch in 'ab' sequence
                    }
                }
                _ => {
                    // Input string guaranteed to only contain 'a', 'b', 'c'
                    // but as a safeguard, any other char would make it invalid.
                    return false; 
                }
            }
        }

        stack.is_empty()
    }
}