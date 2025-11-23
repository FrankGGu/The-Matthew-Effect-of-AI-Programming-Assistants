impl Solution {
    pub fn attendance_record_i(s: String) -> bool {
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
                    if late_streak >= 3 {
                        return false;
                    }
                }
                _ => {
                    late_streak = 0;
                }
            }
        }
        absent_count < 2
    }
}