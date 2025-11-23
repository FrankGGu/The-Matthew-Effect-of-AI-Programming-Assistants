impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn max_satisfaction(mut satisfaction: Vec<i32>) -> i32 {
        satisfaction.sort();
        let mut dq = VecDeque::new();
        let mut total = 0;
        let mut res = 0;

        while let Some(s) = satisfaction.pop() {
            total += s;
            if total > 0 {
                res += total;
                dq.push_back(s);
            } else {
                break;
            }
        }

        res
    }
}
}