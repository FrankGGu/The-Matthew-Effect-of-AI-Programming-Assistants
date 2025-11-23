impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_calls_to_make_array(target: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for &num in &target {
            let mut n = num;
            while n > 0 {
                if n % 2 == 1 {
                    *map.entry(n).or_insert(0) += 1;
                }
                n /= 2;
            }
        }

        for (_, v) in &map {
            count += *v;
        }

        count
    }
}
}