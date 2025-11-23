struct Solution;

impl Solution {
    pub fn min_speed_to_arrive_on_time(employees: Vec<Vec<i32>>) -> i32 {
        fn can_reach(speed: i32, employees: &Vec<Vec<i32>>) -> bool {
            let mut time = 0.0;
            for emp in employees {
                let dist = emp[0];
                let time_limit = emp[1];
                let travel_time = (dist as f64) / (speed as f64);
                time += (travel_time + 1e-9).ceil();
                if time > time_limit as f64 {
                    return false;
                }
            }
            time <= time_limit as f64
        }

        let mut left = 1;
        let mut right = 10000000;
        let mut answer = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if can_reach(mid, &employees) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        answer
    }
}