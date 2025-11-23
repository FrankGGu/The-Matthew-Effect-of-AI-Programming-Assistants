impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn sort_students(score: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let k = k as usize;
        let mut score = score;
        score.sort_by(|a, b| {
            if a[k] > b[k] {
                Ordering::Greater
            } else if a[k] < b[k] {
                Ordering::Less
            } else {
                Ordering::Equal
            }
        });
        score
    }
}
}