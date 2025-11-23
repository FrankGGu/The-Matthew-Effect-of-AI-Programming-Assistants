impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn longest_obstacle_course(obstacles: Vec<i32>) -> Vec<i32> {
        let mut res = vec![0; obstacles.len()];
        let mut tails = Vec::new();

        for (i, &obstacle) in obstacles.iter().enumerate() {
            let idx = match tails.binary_search(&obstacle) {
                Ok(i) => i,
                Err(i) => i,
            };

            if idx == tails.len() {
                tails.push(obstacle);
            } else {
                tails[idx] = obstacle;
            }

            res[i] = (idx + 1) as i32;
        }

        res
    }
}
}