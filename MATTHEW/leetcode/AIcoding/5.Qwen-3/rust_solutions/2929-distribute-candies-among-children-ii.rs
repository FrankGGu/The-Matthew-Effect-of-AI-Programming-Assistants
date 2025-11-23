impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distribute_candies(n: i32, limit: i32) -> i32 {
        fn count_ways(total: i32, limit: i32) -> i32 {
            if total < 0 {
                return 0;
            }
            let a = total;
            let b = total - limit;
            if b < 0 {
                return (a + 1) as i32;
            }
            (a + 1) as i32 - (b + 1) as i32
        }

        let mut result = 0;
        for i in 0..=limit {
            for j in 0..=limit {
                let remaining = n - i - j;
                if remaining >= 0 {
                    result += count_ways(remaining, limit);
                }
            }
        }
        result
    }
}
}