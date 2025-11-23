impl Solution {
    pub fn check_record(s: String) -> bool {
        let mut absent_count = 0;
        let mut late_streak = 0;

        for c in s.chars() {
            match c {
                'A' => {
                    absent_count += 1;
                    late_streak = 0;
                }
                'L' => {
                    late_streak += 1;
                    if late_streak > 2 {
                        return false;
                    }
                }
                _ => {
                    late_streak = 0;
                }
            }

            if absent_count > 1 {
                return false;
            }
        }

        true
    }
}