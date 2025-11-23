impl Solution {
    pub fn final_string(s: String) -> String {
        let mut result = String::new();
        let mut reverse = false;

        for ch in s.chars() {
            if ch == '#' {
                if !result.is_empty() {
                    result.pop();
                }
            } else {
                if reverse {
                    result.insert(0, ch);
                } else {
                    result.push(ch);
                }
            }
            if ch == '!' {
                reverse = !reverse;
            }
        }

        if reverse {
            result.chars().rev().collect()
        } else {
            result
        }
    }
}