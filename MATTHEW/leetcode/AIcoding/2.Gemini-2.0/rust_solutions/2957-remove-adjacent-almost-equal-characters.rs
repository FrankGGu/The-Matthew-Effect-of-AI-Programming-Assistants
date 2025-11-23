impl Solution {
    pub fn remove_almost_equal_characters(s: String) -> i32 {
        let mut count = 0;
        let mut chars = s.chars().collect::<Vec<_>>();
        let mut i = 0;
        while i < chars.len() - 1 {
            if (chars[i] as i32 - chars[i + 1] as i32).abs() <= 1 {
                count += 1;
                i += 2;
            } else {
                i += 1;
            }
        }
        count
    }
}