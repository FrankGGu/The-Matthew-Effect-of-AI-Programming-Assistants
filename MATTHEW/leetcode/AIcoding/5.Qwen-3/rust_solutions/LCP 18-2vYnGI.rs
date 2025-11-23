impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn breakfast_number(mut cnt: Vec<i32>, mut price: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        for &p in &price {
            *map.entry(p).or_insert(0) += 1;
        }
        let mut res = 0;
        for (k, v) in &map {
            let mut temp = *v;
            while temp > 0 && cnt[*k as usize] > 0 {
                cnt[*k as usize] -= 1;
                temp -= 1;
                res += 1;
            }
        }
        res
    }
}
}