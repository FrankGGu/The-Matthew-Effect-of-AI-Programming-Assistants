impl Solution {
    pub fn check_valid_string(s: String) -> bool {
        let mut min = 0;
        let mut max = 0;
        for c in s.chars() {
            match c {
                '(' => {
                    min += 1;
                    max += 1;
                },
                ')' => {
                    min = min.saturating_sub(1);
                    max -= 1;
                    if max < 0 {
                        return false;
                    }
                },
                '*' => {
                    min = min.saturating_sub(1);
                    max += 1;
                },
                _ => (),
            }
        }
        min <= 0 && 0 <= max
    }
}