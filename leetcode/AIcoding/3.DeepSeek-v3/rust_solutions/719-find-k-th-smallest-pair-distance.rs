impl Solution {
    pub fn smallest_distance_pair(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort();
        let n = nums.len();
        let mut left = 0;
        let mut right = nums[n - 1] - nums[0];

        while left < right {
            let mid = left + (right - left) / 2;
            let mut count = 0;
            let mut j = 0;

            for i in 0..n {
                while j < n && nums[j] - nums[i] <= mid {
                    j += 1;
                }
                count += j - i - 1;
            }

            if count < k as usize {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}