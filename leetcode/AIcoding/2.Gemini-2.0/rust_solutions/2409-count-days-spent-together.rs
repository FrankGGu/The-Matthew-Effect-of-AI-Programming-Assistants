impl Solution {
    pub fn count_days_together(arrive_alice: String, leave_alice: String, arrive_bob: String, leave_bob: String) -> i32 {
        let days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

        fn to_days(date: &String, days: &[i32]) -> i32 {
            let month = date[..2].parse::<i32>().unwrap();
            let day = date[3..].parse::<i32>().unwrap();
            let mut total_days = 0;
            for i in 0..month - 1 {
                total_days += days[i as usize];
            }
            total_days + day
        }

        let arrive_a = to_days(&arrive_alice, &days);
        let leave_a = to_days(&leave_alice, &days);
        let arrive_b = to_days(&arrive_bob, &days);
        let leave_b = to_days(&leave_bob, &days);

        let start = std::cmp::max(arrive_a, arrive_b);
        let end = std::cmp::min(leave_a, leave_b);

        if start > end {
            0
        } else {
            end - start + 1
        }
    }
}