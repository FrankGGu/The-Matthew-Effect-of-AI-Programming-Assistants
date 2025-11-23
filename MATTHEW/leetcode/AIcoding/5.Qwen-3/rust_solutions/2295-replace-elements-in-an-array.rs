impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn replace_elements(arr: Vec<i32>) -> Vec<i32> {
        let mut max_val = -1;
        let mut result = arr.clone();

        for i in (0..result.len()).rev() {
            let temp = result[i];
            result[i] = max_val;
            if temp > max_val {
                max_val = temp;
            }
        }

        result
    }
}
}