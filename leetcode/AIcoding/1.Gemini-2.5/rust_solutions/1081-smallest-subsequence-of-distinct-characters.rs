impl Solution {
    pub fn smallest_subsequence(s: String) -> String {
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut stack: Vec<char> = Vec::new();
        let mut in_stack = [false; 26];

        for c in s.chars() {
            let char_idx = (c as u8 - b'a') as usize;

            counts[char_idx] -= 1;

            if in_stack[char_idx] {
                continue;
            }

            while let Some(&top_char) = stack.last() {
                let top_char_idx = (top_char as u8 - b'a') as usize;
                if c < top_char && counts[top_char_idx] > 0 {
                    stack.pop();
                    in_stack[top_char_idx] = false;
                } else {
                    break;
                }
            }

            stack.push(c);
            in_stack[char_idx] = true;
        }

        stack.iter().collect()
    }
}