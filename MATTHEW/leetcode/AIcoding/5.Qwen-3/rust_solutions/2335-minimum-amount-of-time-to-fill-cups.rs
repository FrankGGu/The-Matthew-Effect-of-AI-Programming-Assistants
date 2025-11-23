impl Solution {

use std::cmp::min;

impl Solution {
    pub fn fill_cups(mut capacity: Vec<i32>) -> i32 {
        capacity.sort();
        let mut time = 0;
        while capacity[1] > 0 {
            capacity[0] -= 1;
            capacity[1] -= 1;
            time += 1;
            if capacity[0] < 0 {
                capacity[0] = 0;
            }
            if capacity[1] < 0 {
                capacity[1] = 0;
            }
            capacity.sort();
        }
        time
    }
}
}