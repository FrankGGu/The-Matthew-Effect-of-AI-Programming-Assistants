struct Solution;

impl Solution {
    pub fn split_array(nums: Vec<i32>, m: i32) -> i32 {
        let mut left = *nums.iter().max().unwrap();
        let mut right = nums.iter().sum();

        while left < right {
            let mid = (left + right) / 2;
            let mut count = 1;
            let mut current_sum = 0;

            for &num in &nums {
                if current_sum + num > mid {
                    count += 1;
                    current_sum = num;
                } else {
                    current_sum += num;
                }
            }

            if count <= m {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}