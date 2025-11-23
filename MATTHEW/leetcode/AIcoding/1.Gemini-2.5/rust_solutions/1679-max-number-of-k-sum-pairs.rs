impl Solution {
    pub fn max_operations(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();
        let mut count = 0;
        let mut left: usize = 0;
        let mut right: usize = nums.len();

        if right == 0 {
            return 0;
        }
        right -= 1;

        while left < right {
            let current_sum = nums[left] + nums[right];
            if current_sum == k {
                count += 1;
                left += 1;
                right -= 1;
            } else if current_sum < k {
                left += 1;
            } else { // current_sum > k
                right -= 1;
            }
        }
        count
    }
}