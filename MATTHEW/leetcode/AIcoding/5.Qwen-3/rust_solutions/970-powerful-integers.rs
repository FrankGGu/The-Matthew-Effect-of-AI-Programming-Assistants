impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn powerful_integers(x: i32, y: i32, bound: i32) -> Vec<i32> {
        let mut result = HashSet::new();
        let mut i = 0;
        while x.pow(i as u32) <= bound {
            let mut j = 0;
            while x.pow(i as u32) + y.pow(j as u32) <= bound {
                result.insert(x.pow(i as u32) + y.pow(j as u32));
                j += 1;
            }
            i += 1;
        }
        result.into_iter().collect()
    }
}
}