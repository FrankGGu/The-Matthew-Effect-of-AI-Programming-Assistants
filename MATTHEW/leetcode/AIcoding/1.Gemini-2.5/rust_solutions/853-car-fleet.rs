struct Solution;

impl Solution {
    pub fn car_fleet(target: i32, position: Vec<i32>, speed: Vec<i32>) -> i32 {
        let n = position.len();
        if n == 0 {
            return 0;
        }

        let mut cars: Vec<(i32, i32)> = position.into_iter()
            .zip(speed.into_iter())
            .collect();

        cars.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut fleets = 0;
        let mut max_time_seen = 0.0;

        for i in 0..n {
            let p = cars[i].0;
            let s = cars[i].1;

            let time_to_target = (target - p) as f64 / s as f64;

            if time_to_target > max_time_seen {
                fleets += 1;
                max_time_seen = time_to_target;
            }
        }

        fleets
    }
}