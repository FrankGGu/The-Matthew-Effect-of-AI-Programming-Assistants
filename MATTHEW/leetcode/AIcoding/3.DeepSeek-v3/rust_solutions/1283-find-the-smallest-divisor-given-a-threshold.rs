impl Solution {
    pub fn smallest_divisor(nums: Vec<i32>, threshold: i32) -> i32 {
        let mut left = 1;
        let mut right = *nums.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let sum: i32 = nums.iter().map(|&x| (x + mid - 1) / mid).sum();
            if sum > threshold {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}