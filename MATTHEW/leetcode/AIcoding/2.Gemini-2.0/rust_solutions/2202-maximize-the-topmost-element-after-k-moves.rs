impl Solution {
    pub fn maximum_top(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;

        if n == 1 {
            if k % 2 == 0 {
                return nums[0];
            } else {
                return -1;
            }
        }

        if k > n {
            return -1;
        }

        if k == n {
            let mut max_val = -1;
            for i in 0..n - 1 {
                max_val = max_val.max(nums[i]);
            }
            return max_val;
        }

        let mut max_val = -1;
        for i in 0..k - 1 {
            max_val = max_val.max(nums[i]);
        }
        max_val = max_val.max(nums[k]);

        return max_val;
    }
}