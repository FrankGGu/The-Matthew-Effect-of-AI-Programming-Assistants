impl Solution {
    pub fn count_segments(s: String) -> i32 {
        s.split_whitespace().filter(|x| !x.is_empty()).count() as i32
    }
}