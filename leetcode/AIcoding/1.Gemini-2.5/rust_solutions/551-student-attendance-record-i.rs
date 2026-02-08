impl Solution {
    pub fn check_record(s: String) -> bool {
        let mut absent_count = 0;
        let mut consecutive_lates = 0;

        for c in s.chars() {
            match c {
                'A' => {
                    absent_count += 1;
                    consecutive_lates = 0;
                }
                'L' => {
                    consecutive_lates += 1;
                }
                'P' => {
                    consecutive_lates = 0;
                }
                _ => {}
            }

            if absent_count >= 2 {
                return false;
            }
            if consecutive_lates >= 3 {
                return false;
            }
        }

        true
    }
}