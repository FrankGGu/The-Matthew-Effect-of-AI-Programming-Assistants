impl Solution {
    pub fn eliminate_maximum(dist: Vec<i32>, speed: Vec<i32>) -> i32 {
        let mut time_to_city: Vec<i32> = dist.iter().zip(speed.iter())
            .map(|(&d, &s)| (d + s - 1) / s)
            .collect();
        time_to_city.sort_unstable();

        for (i, &time) in time_to_city.iter().enumerate() {
            if time <= i as i32 {
                return i as i32;
            }
        }

        time_to_city.len() as i32
    }
}