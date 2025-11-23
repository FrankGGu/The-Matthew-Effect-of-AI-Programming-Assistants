impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn delete_and Earn(n: i32, mut s: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        s.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut result = vec![s[0].clone()];
        for i in 1..n {
            let last = result.last().unwrap();
            if s[i][0] > last[1] {
                result.push(s[i].clone());
            } else {
                let new_end = std::cmp::max(last[1], s[i][1]);
                result.last_mut().unwrap()[1] = new_end;
            }
        }
        result
    }
}
}