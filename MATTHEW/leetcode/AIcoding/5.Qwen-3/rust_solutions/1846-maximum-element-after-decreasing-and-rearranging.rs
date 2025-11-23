impl Solution {

use std::cmp::Reverse;

impl Solution {
    pub fn maximum_element(arr: Vec<i32>) -> i32 {
        let mut arr = arr;
        arr.sort_by_key(|&x| Reverse(x));
        let mut max = arr[0];
        for i in 1..arr.len() {
            if arr[i] < max - 1 {
                return max - 1;
            }
            max = arr[i];
        }
        max
    }
}
}