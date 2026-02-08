impl Solution {
    pub fn poor_pigs(buckets: i32, minutes_to_die: i32, minutes_to_test: i32) -> i32 {
        if buckets == 1 {
            return 0;
        }
        let time = minutes_to_test / minutes_to_die;
        let mut pigs = 0;
        let mut state = 1;
        while state < buckets {
            state *= (time + 1);
            pigs += 1;
        }
        pigs
    }
}