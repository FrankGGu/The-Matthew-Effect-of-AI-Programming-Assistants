impl Solution {
    pub fn min_remove_to_make_valid(s: String) -> String {
        let mut stack: Vec<usize> = Vec::new();
        let mut indices_to_remove: Vec<usize> = Vec::new();
        let chars: Vec<char> = s.chars().collect();

        for (i, &c) in chars.iter().enumerate() {
            if c == '(' {
                stack.push(i);
            } else if c == ')' {
                if stack.is_empty() {
                    indices_to_remove.push(i);
                } else {
                    stack.pop();
                }
            }
        }

        indices_to_remove.extend(stack);
        indices_to_remove.sort();

        let mut result = String::new();
        let mut remove_index = 0;

        for (i, &c) in chars.iter().enumerate() {
            if remove_index < indices_to_remove.len() && i == indices_to_remove[remove_index] {
                remove_index += 1;
            } else {
                result.push(c);
            }
        }

        result
    }
}