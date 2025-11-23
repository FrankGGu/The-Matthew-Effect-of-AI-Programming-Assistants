impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

impl Solution {
    pub fn find_k_closest(mut arr: Vec<i32>, mut k: i32, x: i32) -> Vec<i32> {
        let mut left = 0;
        let mut right = arr.len() as isize - 1;

        while right - left >= k {
            if (arr[left] as isize - x).abs() > (arr[right] as isize - x).abs() {
                left += 1;
            } else {
                right -= 1;
            }
        }

        arr[left as usize..right as usize + 1].to_vec()
    }
}
}