impl Solution {
    pub fn count_days_together(arrive_a: String, leave_a: String, arrive_b: String, leave_b: String) -> i32 {
        let start_a = Self::to_days(&arrive_a);
        let end_a = Self::to_days(&leave_a);
        let start_b = Self::to_days(&arrive_b);
        let end_b = Self::to_days(&leave_b);

        let start = start_a.max(start_b);
        let end = end_a.min(end_b);

        if start > end {
            0
        } else {
            (end - start + 1) as i32
        }
    }

    fn to_days(date: &str) -> i32 {
        let parts: Vec<&str> = date.split('-').collect();
        let month = parts[0].parse::<i32>().unwrap();
        let day = parts[1].parse::<i32>().unwrap();
        let days_in_month = [0, 0, 31, 28, 31, 30, 31, 31, 30, 31, 30, 31];
        let mut days = 0;
        for m in 1..month {
            days += days_in_month[m as usize];
        }
        days + day
    }
}