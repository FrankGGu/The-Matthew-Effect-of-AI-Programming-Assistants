impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn sort_people(mut names: Vec<String>, mut heights: Vec<i32>) -> Vec<String> {
        let mut people: Vec<(i32, String)> = names.into_iter().zip(heights.into_iter()).collect();

        people.sort_by(|a, b| b.0.cmp(&a.0));

        people.into_iter().map(|p| p.1).collect()
    }
}
}