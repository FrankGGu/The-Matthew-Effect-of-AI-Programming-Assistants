impl Solution {
    pub fn min_cost_set_time(current: i32, start: i32, end: i32) -> i32 {
        let mut min_cost = i32::MAX;
        for t in start..=end {
            let hours = t / 60;
            let minutes = t % 60;
            let cost = (current / 60 - hours).abs() + (current % 60 - minutes).abs();
            min_cost = min_cost.min(cost);
        }
        min_cost
    }
}