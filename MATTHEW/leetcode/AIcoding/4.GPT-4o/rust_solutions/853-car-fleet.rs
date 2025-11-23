pub fn car_fleet(target: i32, position: Vec<i32>, speed: Vec<i32>) -> i32 {
    let mut cars: Vec<(i32, f64)> = position.into_iter().zip(speed.into_iter()).collect();
    cars.sort_unstable_by(|a, b| b.0.cmp(&a.0));

    let mut fleets = 0;
    let mut time_to_reach = 0.0;

    for (pos, spd) in cars {
        let time = (target - pos) as f64 / spd as f64;
        if time > time_to_reach {
            fleets += 1;
            time_to_reach = time;
        }
    }

    fleets
}