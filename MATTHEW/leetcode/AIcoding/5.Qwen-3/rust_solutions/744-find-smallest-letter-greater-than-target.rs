impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn next_greatest_letter(letters: Vec<char>, target: char) -> char {
        let mut left = 0;
        let mut right = letters.len();

        while left < right {
            let mid = (left + right) / 2;
            match letters[mid].cmp(&target) {
                Ordering::Less => left = mid + 1,
                _ => right = mid,
            }
        }

        letters[left % letters.len()]
    }
}
}