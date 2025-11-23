impl Solution {
    pub fn convert_time(current: String, correct: String) -> i32 {
        let parse_time = |s: String| -> i32 {
            let parts: Vec<&str> = s.split(':').collect();
            let hours = parts[0].parse::<i32>().unwrap();
            let minutes = parts[1].parse::<i32>().unwrap();
            hours * 60 + minutes
        };

        let current_minutes = parse_time(current);
        let correct_minutes = parse_time(correct);

        let mut diff = correct_minutes - current_minutes;
        let mut operations = 0;

        operations += diff / 60;
        diff %= 60;

        operations += diff / 15;
        diff %= 15;

        operations += diff / 5;
        diff %= 5;

        operations += diff;

        operations
    }
}