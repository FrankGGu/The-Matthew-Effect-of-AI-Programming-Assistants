impl Solution {
    pub fn longest_common_prefix_after_removal(strs: Vec<String>) -> String {
        if strs.is_empty() {
            return String::new();
        }

        let mut min_len = strs[0].len();
        for s in &strs {
            min_len = min_len.min(s.len());
        }

        let mut prefix = String::new();
        for i in 0..min_len {
            let mut char_match = true;
            let c = strs[0].chars().nth(i).unwrap();
            for s in &strs {
                if s.chars().nth(i).unwrap() != c {
                    char_match = false;
                    break;
                }
            }
            if char_match {
                prefix.push(c);
            } else {
                break;
            }
        }

        prefix
    }
}