impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn count_fair_pairs(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let n = nums.len();
        let mut count = 0;
        let mut sorted = nums.clone();
        sorted.sort();

        for i in 0..n {
            let left = 0;
            let right = i - 1;
            let target = nums[i];
            let mut low = 0;
            let mut high = i - 1;
            while low <= high {
                let mid = (low + high) / 2;
                match sorted[mid].cmp(&target) {
                    Ordering::Less => low = mid + 1,
                    _ => high = mid - 1,
                }
            }
            count += low;
        }

        count as i32
    }
}
}