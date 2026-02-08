impl Solution {
    pub fn poor_pigs(buckets: i32, minutes_to_die: i32, minutes_to_test: i32) -> i32 {
        let k = minutes_to_test / minutes_to_die;
        let base = k + 1;

        let mut pigs = 0;
        let mut power = 1;

        while power < buckets {
            power *= base;
            pigs += 1;
        }

        pigs
    }
}