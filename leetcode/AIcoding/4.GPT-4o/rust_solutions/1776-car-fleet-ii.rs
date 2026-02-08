impl Solution {
    pub fn car_fleet(target: i32, position: Vec<i32>, speed: Vec<i32>) -> i32 {
        let mut cars: Vec<(i32, f64)> = position.into_iter().zip(speed).collect();
        cars.sort_unstable_by(|a, b| b.0.cmp(&a.0));
        let mut fleets = 0;
        let mut time = 0.0;

        for (pos, spd) in cars {
            let arrival_time = (target - pos) as f64 / spd as f64;
            if arrival_time > time {
                fleets += 1;
                time = arrival_time;
            }
        }

        fleets
    }
}