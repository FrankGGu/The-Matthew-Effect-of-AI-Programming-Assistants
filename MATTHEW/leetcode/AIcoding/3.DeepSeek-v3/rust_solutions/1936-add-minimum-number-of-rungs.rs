impl Solution {
    pub fn add_rungs(rungs: Vec<i32>, dist: i32) -> i32 {
        let mut res = 0;
        let mut prev = 0;
        for rung in rungs {
            let diff = rung - prev;
            res += (diff - 1) / dist;
            prev = rung;
        }
        res
    }
}