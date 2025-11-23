impl Solution {
    pub fn num_different_integers(word: String) -> i32 {
        use std::collections::HashSet;

        let mut nums = HashSet::new();
        let mut current_num = String::new();

        for c in word.chars() {
            if c.is_digit(10) {
                current_num.push(c);
            } else {
                if !current_num.is_empty() {
                    let num = current_num.trim_start_matches('0');
                    if num.is_empty() {
                        nums.insert("0".to_string());
                    } else {
                        nums.insert(num.to_string());
                    }
                    current_num = String::new();
                }
            }
        }

        if !current_num.is_empty() {
            let num = current_num.trim_start_matches('0');
            if num.is_empty() {
                nums.insert("0".to_string());
            } else {
                nums.insert(num.to_string());
            }
        }

        nums.len() as i32
    }
}