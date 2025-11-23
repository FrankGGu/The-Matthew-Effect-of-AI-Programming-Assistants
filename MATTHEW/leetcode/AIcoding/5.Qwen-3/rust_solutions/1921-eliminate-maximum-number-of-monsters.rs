impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn eliminate_maximum(mut dist: Vec<i32>, mut speed: Vec<i32>) -> i32 {
        let n = dist.len();
        for i in 0..n {
            dist[i] = dist[i] / speed[i];
            if dist[i] * speed[i] < dist[i] {
                dist[i] += 1;
            }
        }

        dist.sort();

        for i in 0..n {
            if dist[i] <= i as i32 {
                return i as i32;
            }
        }

        n as i32
    }
}
}