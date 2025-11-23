impl Solution {
    pub fn add_rungs(rungs: Vec<i32>, dist: i32) -> i32 {
        let mut added_rungs = 0;
        let mut prev_rung = 0;

        for &rung in rungs.iter() {
            let diff = rung - prev_rung;
            if diff > dist {
                added_rungs += (diff - 1) / dist;
            }
            prev_rung = rung;
        }

        added_rungs
    }
}