impl Solution {
    pub fn add_rungs(rungs: Vec<i32>, dist: i32) -> i32 {
        let mut count = 0;
        let mut current = 0;

        for &rung in &rungs {
            while current + dist < rung {
                current += dist;
                count += 1;
            }
            current = rung;
        }

        count
    }
}