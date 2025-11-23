impl Solution {
    pub fn poor_pigs(buckets: i32, minutes_to_die: i32, minutes_to_test: i32) -> i32 {
        let tests = minutes_to_test / minutes_to_die;
        let pigs = ((buckets as f64).log(1.0 + tests as f64) / (1.0_f64).log(2.0)).ceil() as i32;
        pigs
    }
}