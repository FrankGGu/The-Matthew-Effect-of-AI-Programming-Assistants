impl Solution {
    pub fn check_balanced_string(s: String) -> bool {
        let mut count = 0;
        for c in s.chars() {
            match c {
                'L' => count += 1,
                'R' => count -= 1,
                _ => {},
            }
        }
        count == 0
    }
}