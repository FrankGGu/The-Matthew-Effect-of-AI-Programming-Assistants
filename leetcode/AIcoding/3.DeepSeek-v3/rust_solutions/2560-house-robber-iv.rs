impl Solution {
    pub fn min_capability(nums: Vec<i32>, k: i32) -> i32 {
        let mut left = *nums.iter().min().unwrap();
        let mut right = *nums.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::can_rob(&nums, k, mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left
    }

    fn can_rob(nums: &Vec<i32>, k: i32, max_money: i32) -> bool {
        let mut count = 0;
        let mut i = 0;
        let n = nums.len();

        while i < n {
            if nums[i] <= max_money {
                count += 1;
                i += 1;
                if count >= k {
                    return true;
                }
            }
            i += 1;
        }
        count >= k
    }
}