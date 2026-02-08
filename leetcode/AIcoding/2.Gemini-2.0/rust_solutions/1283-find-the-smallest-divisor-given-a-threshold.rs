impl Solution {
    pub fn smallest_divisor(nums: Vec<i32>, threshold: i32) -> i32 {
        let mut left = 1;
        let mut right = *nums.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut sum = 0;
            for &num in &nums {
                sum += (num as f64 / mid as f64).ceil() as i32;
            }

            if sum > threshold {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}