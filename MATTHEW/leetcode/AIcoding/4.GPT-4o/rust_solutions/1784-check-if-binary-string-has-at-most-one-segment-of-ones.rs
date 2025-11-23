impl Solution {
    pub fn check_ones_segment(s: String) -> bool {
        let segments: Vec<&str> = s.split('0').collect();
        segments.len() <= 2
    }
}