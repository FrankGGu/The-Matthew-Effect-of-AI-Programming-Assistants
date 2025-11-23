impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn beautiful_array(mut n: i32) -> Vec<i32> {
        let mut result = vec![1];
        while result.len() < n as usize {
            let mut temp = vec![];
            for &num in &result {
                if num * 2 - 1 <= n {
                    temp.push(num * 2 - 1);
                }
            }
            for &num in &result {
                if num * 2 <= n {
                    temp.push(num * 2);
                }
            }
            result = temp;
        }
        result
    }
}
}