impl Solution {
    pub fn count_days_together(arrive_alice: String, leave_alice: String, arrive_bob: String, leave_bob: String) -> i32 {
        fn parse_date(s: String) -> i32 {
            let parts: Vec<&str> = s.split('-').collect();
            let month: i32 = parts[0].parse().unwrap();
            let day: i32 = parts[1].parse().unwrap();
            let days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            let mut total = 0;
            for m in 1..month {
                total += days_in_month[(m - 1) as usize];
            }
            total + day
        }

        let alice_arrive = parse_date(arrive_alice);
        let alice_leave = parse_date(leave_alice);
        let bob_arrive = parse_date(arrive_bob);
        let bob_leave = parse_date(leave_bob);

        let start = alice_arrive.max(bob_arrive);
        let end = alice_leave.min(bob_leave);

        if start > end {
            0
        } else {
            end - start + 1
        }
    }
}