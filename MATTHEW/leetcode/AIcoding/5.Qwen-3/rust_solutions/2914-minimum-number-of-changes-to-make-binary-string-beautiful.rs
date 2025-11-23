struct Solution;

impl Solution {
    pub fn min_changes(s: String) -> i32 {
        let mut count = 0;
        let chars: Vec<char> = s.chars().collect();
        for i in (0..chars.len()).step_by(2) {
            if chars[i] != chars[i + 1] {
                count += 1;
            }
        }
        count
    }
}