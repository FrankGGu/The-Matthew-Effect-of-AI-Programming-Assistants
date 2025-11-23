impl Solution {
    pub fn car_fleet(target: i32, position: Vec<i32>, speed: Vec<i32>) -> i32 {
        let mut cars: Vec<(i32, f64)> = position
            .into_iter()
            .zip(speed.into_iter())
            .map(|(p, s)| (p, (target - p) as f64 / s as f64))
            .collect();
        cars.sort_by(|a, b| b.0.cmp(&a.0));

        let mut res = 0;
        let mut curr_time = 0.0;

        for (_, time) in cars {
            if time > curr_time {
                res += 1;
                curr_time = time;
            }
        }

        res
    }
}