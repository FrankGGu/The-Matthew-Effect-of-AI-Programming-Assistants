impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(collect_coins: Vec<i32>) -> i32 {
        let mut q = VecDeque::new();
        for &coin in &collect_coins {
            q.push_back(coin);
        }

        let mut operations = 0;
        let mut k = 1;

        while !q.is_empty() {
            let mut steps = 0;
            let mut new_q = VecDeque::new();
            let mut count = 0;

            while !q.is_empty() {
                let coin = q.pop_front().unwrap();
                if count < k {
                    count += 1;
                } else {
                    new_q.push_back(coin);
                }
            }

            if count < k {
                break;
            }

            q = new_q;
            operations += 1;
            k *= 2;
        }

        operations
    }
}
}