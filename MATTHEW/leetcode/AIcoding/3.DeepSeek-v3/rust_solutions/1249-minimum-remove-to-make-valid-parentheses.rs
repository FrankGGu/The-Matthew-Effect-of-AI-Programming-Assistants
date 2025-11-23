impl Solution {
    pub fn min_remove_to_make_valid(s: String) -> String {
        let mut stack = Vec::new();
        let mut s_chars: Vec<char> = s.chars().collect();

        for i in 0..s_chars.len() {
            match s_chars[i] {
                '(' => stack.push(i),
                ')' => {
                    if stack.is_empty() {
                        s_chars[i] = '\0';
                    } else {
                        stack.pop();
                    }
                }
                _ => {}
            }
        }

        for &i in &stack {
            s_chars[i] = '\0';
        }

        s_chars.into_iter().filter(|&c| c != '\0').collect()
    }
}