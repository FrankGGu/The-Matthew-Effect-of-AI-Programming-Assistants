struct Solution;

impl Solution {
    const CUMULATIVE_DAYS: [i32; 12] = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

    fn date_to_day_of_year(date_str: &str) -> i32 {
        let parts: Vec<&str> = date_str.split('-').collect();
        let month = parts[0].parse::<usize>().unwrap();
        let day = parts[1].parse::<i32>().unwrap();
        Self::CUMULATIVE_DAYS[month - 1] + day
    }

    pub fn count_days_spent_together(
        alice_arrive: String,
        alice_leave: String,
        bob_arrive: String,
        bob_leave: String,
    ) -> i32 {
        let alice_arrive_day = Self::date_to_day_of_year(&alice_arrive);
        let alice_leave_day = Self::date_to_day_of_year(&alice_leave);
        let bob_arrive_day = Self::date_to_day_of_year(&bob_arrive);
        let bob_leave_day = Self::date_to_day_of_year(&bob_leave);

        let intersect_start = alice_arrive_day.max(bob_arrive_day);
        let intersect_end = alice_leave_day.min(bob_leave_day);

        if intersect_start > intersect_end {
            0
        } else {
            intersect_end - intersect_start + 1
        }
    }
}