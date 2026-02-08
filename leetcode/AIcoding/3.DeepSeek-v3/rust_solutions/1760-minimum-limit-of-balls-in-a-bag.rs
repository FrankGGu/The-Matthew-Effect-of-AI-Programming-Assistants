impl Solution {
    pub fn minimum_size(nums: Vec<i32>, max_operations: i32) -> i32 {
        let mut left = 1;
        let mut right = *nums.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let operations: i32 = nums.iter().map(|&x| (x - 1) / mid).sum();

            if operations > max_operations {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}