impl Solution {
    pub fn make_strings_equal(s: String, target: String) -> bool {
        if s.len() != target.len() {
            return false;
        }
        let s_has_one = s.contains('1');
        let target_has_one = target.contains('1');
        s_has_one == target_has_one
    }
}