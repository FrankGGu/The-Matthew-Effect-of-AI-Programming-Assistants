impl Solution {
    pub fn find_occurrence_of_first_almost_equal_substring(s: String, t: String) -> i32 {
        let n = s.len();
        let m = t.len();
        for i in 0..=n - m {
            if s[i..i + m] == t {
                return i as i32;
            }
        }
        -1
    }
}