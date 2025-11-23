impl Solution {
    pub fn minimum_deletions(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 2 {
            return n as i32;
        }

        let mut min_idx = 0;
        let mut max_idx = 0;

        for i in 1..n {
            if nums[i] < nums[min_idx] {
                min_idx = i;
            }
            if nums[i] > nums[max_idx] {
                max_idx = i;
            }
        }

        let left = std::cmp::max(min_idx, max_idx) + 1;
        let right = n - std::cmp::min(min_idx, max_idx);
        let both = (std::cmp::min(min_idx, max_idx) + 1) + (n - std::cmp::max(min_idx, max_idx));

        std::cmp::min(std::cmp::min(left, right), both) as i32
    }
}