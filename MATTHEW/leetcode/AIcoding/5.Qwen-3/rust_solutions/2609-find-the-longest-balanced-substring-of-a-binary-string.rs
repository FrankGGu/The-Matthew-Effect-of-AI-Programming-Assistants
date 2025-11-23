struct Solution;

impl Solution {
    pub fn longest_balanced_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut count = 0;
        let mut zero_count = 0;
        let mut one_count = 0;

        for c in s.chars() {
            match c {
                '0' => {
                    zero_count += 1;
                    one_count = 0;
                }
                '1' => {
                    one_count += 1;
                    zero_count = 0;
                }
                _ => {}
            }

            if zero_count == one_count {
                max_len = std::cmp::max(max_len, zero_count * 2);
            }
        }

        max_len as i32
    }
}