impl Solution {
    pub fn add_minimum_number_of_rungs(rungs: Vec<i32>, dist: i32) -> i32 {
        let mut count = 0;
        let mut prev = 0;
        for &rung in &rungs {
            if rung - prev > dist {
                count += (rung - prev - 1) / dist;
            }
            prev = rung;
        }
        count
    }
}