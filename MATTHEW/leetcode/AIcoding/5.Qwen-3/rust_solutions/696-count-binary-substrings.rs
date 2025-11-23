struct Solution;

impl Solution {
    pub fn count_binary_substrings(s: String) -> i32 {
        let mut prev_count = 0;
        let mut curr_count = 0;
        let mut result = 0;
        let s: Vec<char> = s.chars().collect();

        for i in 0..s.len() {
            if i > 0 && s[i] != s[i - 1] {
                prev_count = curr_count;
                curr_count = 1;
            } else {
                curr_count += 1;
            }
            if prev_count < curr_count {
                result += prev_count;
            } else {
                result += curr_count;
            }
        }

        result
    }
}