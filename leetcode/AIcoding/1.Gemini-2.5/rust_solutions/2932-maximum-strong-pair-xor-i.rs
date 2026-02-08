impl Solution {
    pub fn maximum_strong_pair_xor(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_xor_val = 0;

        for i in 0..n {
            for j in 0..n {
                let x = nums[i];
                let y = nums[j];

                let min_val = x.min(y);
                let max_val = x.max(y);

                if max_val <= 2 * min_val {
                    max_xor_val = max_xor_val.max(x ^ y);
                }
            }
        }

        max_xor_val
    }
}