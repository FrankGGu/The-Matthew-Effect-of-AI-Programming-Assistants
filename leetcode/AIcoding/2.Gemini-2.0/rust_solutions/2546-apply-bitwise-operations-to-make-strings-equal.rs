impl Solution {
    pub fn make_strings_equal(s: String, target: String) -> bool {
        let s_has_one = s.chars().any(|c| c == '1');
        let target_has_one = target.chars().any(|c| c == '1');

        if s_has_one == target_has_one {
            return true;
        } else {
            return false;
        }
    }
}