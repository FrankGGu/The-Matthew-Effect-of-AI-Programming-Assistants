impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn can_complete_circuit(gas: Vec<i32>, cost: Vec<i32>) -> i32 {
        let n = gas.len();
        let mut total_tank = 0;
        let mut curr_tank = 0;
        let mut start = 0;

        for i in 0..n {
            total_tank += gas[i] - cost[i];
            curr_tank += gas[i] - cost[i];
            if curr_tank < 0 {
                start = i + 1;
                curr_tank = 0;
            }
        }

        if total_tank >= 0 {
            start as i32
        } else {
            -1
        }
    }
}
}