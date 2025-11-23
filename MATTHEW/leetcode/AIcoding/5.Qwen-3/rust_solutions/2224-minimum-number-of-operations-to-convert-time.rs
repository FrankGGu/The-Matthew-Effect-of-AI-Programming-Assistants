struct Solution;

impl Solution {
    pub fn convert_time(mut target: String, mut current: String) -> i32 {
        let target_minutes = Self::to_minutes(&target);
        let current_minutes = Self::to_minutes(&current);

        let mut operations = 0;
        let mut remaining = target_minutes - current_minutes;

        for &unit in &[60, 15, 5, 1] {
            if remaining >= unit {
                operations += remaining / unit;
                remaining %= unit;
            }
        }

        operations
    }

    fn to_minutes(time: &str) -> i32 {
        let parts: Vec<&str> = time.split(':').collect();
        let hours = parts[0].parse::<i32>().unwrap();
        let minutes = parts[1].parse::<i32>().unwrap();
        hours * 60 + minutes
    }
}