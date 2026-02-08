impl Solution {
    pub fn car_fleet(target: i32, position: Vec<i32>, speed: Vec<i32>) -> i32 {
        let mut cars: Vec<(i32, i32)> = position.into_iter().zip(speed.into_iter()).collect();
        cars.sort_by(|a, b| a.0.cmp(&b.0));

        let mut times: Vec<f64> = cars.iter().map(|&(p, s)| (target - p) as f64 / s as f64).collect();

        let mut fleets = 0;
        let mut max_time = 0.0;

        for &time in times.iter().rev() {
            if time > max_time {
                fleets += 1;
                max_time = time;
            }
        }

        fleets
    }
}