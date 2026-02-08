impl Solution {
    pub fn final_string(s: String) -> String {
        let mut result = String::new();
        let mut backspace_count = 0;

        for c in s.chars().rev() {
            if c == '#' {
                backspace_count += 1;
            } else if backspace_count > 0 {
                backspace_count -= 1;
            } else {
                result.push(c);
            }
        }

        result.chars().rev().collect()
    }
}