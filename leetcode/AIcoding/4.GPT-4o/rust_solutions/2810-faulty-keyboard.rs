impl Solution {
    pub fn final_string(s: String) -> String {
        let mut result = String::new();
        let mut reverse = false;

        for c in s.chars() {
            if c == 'i' {
                reverse = !reverse;
            } else {
                if reverse {
                    result.insert(0, c);
                } else {
                    result.push(c);
                }
            }
        }

        if reverse {
            result.chars().rev().collect()
        } else {
            result
        }
    }
}