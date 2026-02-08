impl Solution {
    pub fn check_record(s: String) -> bool {
        let mut a_count = 0;
        let mut l_count = 0;

        for c in s.chars() {
            if c == 'A' {
                a_count += 1;
                if a_count > 1 {
                    return false;
                }
            }
            if c == 'L' {
                l_count += 1;
                if l_count > 2 {
                    return false;
                }
            } else {
                l_count = 0;
            }
        }
        true
    }
}