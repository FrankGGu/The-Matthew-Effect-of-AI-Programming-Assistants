impl Solution {
    pub fn split_array(nums: Vec<i32>, k: i32) -> i32 {
        let mut left = *nums.iter().max().unwrap_or(&0);
        let mut right: i32 = nums.iter().sum();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut sum = 0;
            let mut count = 1;

            for &num in &nums {
                if sum + num > mid {
                    sum = num;
                    count += 1;
                } else {
                    sum += num;
                }
            }

            if count > k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}