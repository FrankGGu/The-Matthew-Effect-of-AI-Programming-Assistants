impl Solution {
    pub fn poor_pigs(buckets: i32, minutes_to_die: i32, minutes_to_test: i32) -> i32 {
        let tests = minutes_to_test / minutes_to_die;
        ((buckets as f64).ln() / ((tests + 1) as f64).ln()).ceil() as i32
    }
}