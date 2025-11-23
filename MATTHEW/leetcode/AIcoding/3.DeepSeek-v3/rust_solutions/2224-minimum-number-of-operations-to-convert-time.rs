impl Solution {
    pub fn convert_time(current: String, correct: String) -> i32 {
        let parse_time = |s: String| -> i32 {
            let parts: Vec<&str> = s.split(':').collect();
            let hours: i32 = parts[0].parse().unwrap();
            let minutes: i32 = parts[1].parse().unwrap();
            hours * 60 + minutes
        };

        let current_time = parse_time(current);
        let correct_time = parse_time(correct);
        let mut diff = correct_time - current_time;
        let mut operations = 0;

        let increments = [60, 15, 5, 1];
        for inc in increments.iter() {
            operations += diff / inc;
            diff %= inc;
        }

        operations
    }
}