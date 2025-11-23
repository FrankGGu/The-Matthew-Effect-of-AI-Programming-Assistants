struct Solution {}

impl Solution {
    pub fn car_fleet(target: i32, position: Vec<i32>, speed: Vec<i32>) -> i32 {
        let mut cars = position.iter().zip(speed.iter()).map(|(&p, &s)| (p, s)).collect::<Vec<_>>();
        cars.sort_by(|a, b| b.0.cmp(&a.0));

        let mut stack = vec![];
        for (pos, sp) in cars {
            let time = (target as f64 - pos as f64) / sp as f64;
            if stack.is_empty() || time > *stack.last().unwrap() {
                stack.push(time);
            }
        }

        stack.len() as i32
    }
}