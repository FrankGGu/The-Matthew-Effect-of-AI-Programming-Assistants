impl Solution {
    pub fn min_capability(nums: Vec<i32>, k: i32) -> i32 {
        let mut left = 1;
        let mut right = *nums.iter().max().unwrap();
        while left < right {
            let mid = left + (right - left) / 2;
            if Self::can_rob(nums.clone(), k, mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left
    }

    fn can_rob(nums: Vec<i32>, k: i32, max_val: i32) -> bool {
        let mut count = 0;
        let mut robbed = false;
        for &num in &nums {
            if num <= max_val && !robbed {
                count += 1;
                robbed = true;
            } else {
                robbed = false;
            }
        }
        count >= k
    }
}