impl Solution {
    pub fn convert_time(current: String, correct: String) -> i32 {
        let current_time = Self::parse_time(&current);
        let correct_time = Self::parse_time(&correct);
        let diff = correct_time - current_time;

        let mut operations = 0;
        let mut remaining = diff;

        operations += remaining / 60;
        remaining %= 60;

        operations += remaining / 15;
        remaining %= 15;

        operations += remaining / 5;
        remaining %= 5;

        operations += remaining;

        operations
    }

    fn parse_time(time: &String) -> i32 {
        let parts: Vec<&str> = time.split(":").collect();
        let hours: i32 = parts[0].parse().unwrap();
        let minutes: i32 = parts[1].parse().unwrap();
        hours * 60 + minutes
    }
}