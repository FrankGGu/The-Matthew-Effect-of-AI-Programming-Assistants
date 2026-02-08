impl Solution {
    pub fn minimize_max(nums: Vec<i32>, p: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();

        let mut left = 0;
        let mut right = nums[n - 1] - nums[0];
        let mut ans = right;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut count = 0;
            let mut i = 0;
            while i < n - 1 {
                if nums[i + 1] - nums[i] <= mid {
                    count += 1;
                    i += 2;
                } else {
                    i += 1;
                }
            }

            if count >= p {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        ans
    }
}