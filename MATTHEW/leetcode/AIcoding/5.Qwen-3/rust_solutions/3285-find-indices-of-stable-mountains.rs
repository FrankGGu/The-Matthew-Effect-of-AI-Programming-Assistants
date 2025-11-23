impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn stable_mountains(height: Vec<i32>, threshold: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for i in 0..height.len() {
            if i == 0 {
                continue;
            }
            match height[i].cmp(&height[i - 1]) {
                Ordering::Greater => {}
                _ => {
                    if height[i] - height[i - 1] <= threshold {
                        result.push(i as i32);
                    }
                }
            }
        }
        result
    }
}
}