impl Solution {
    pub fn maximum_top(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        if n == 1 {
            return if k % 2 == 1 { -1 } else { nums[0] };
        }
        let mut max = -1;
        for i in 0..std::cmp::min(k - 1, n) {
            if nums[i] > max {
                max = nums[i];
            }
        }
        if k < n && nums[k] > max {
            max = nums[k];
        }
        max
    }
}