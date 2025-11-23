impl Solution {
    pub fn can_be_split(nums: Vec<i32>) -> bool {
        let n = nums.len();

        if n < 2 {
            return false;
        }

        let mut prefix_is_increasing = vec![false; n];
        prefix_is_increasing[0] = true;
        for k in 1..n {
            prefix_is_increasing[k] = prefix_is_increasing[k - 1] && (nums[k - 1] < nums[k]);
        }

        let mut suffix_is_increasing = vec![false; n];
        suffix_is_increasing[n - 1] = true;
        for k in (0..n - 1).rev() {
            suffix_is_increasing[k] = suffix_is_increasing[k + 1] && (nums[k] < nums[k + 1]);
        }

        for i in 0..n - 1 {
            if prefix_is_increasing[i] && suffix_is_increasing[i + 1] {
                return true;
            }
        }

        false
    }
}