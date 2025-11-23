impl Solution {
    pub fn smallest_subarrays(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut max_bit = vec![0; 32];

        for i in (0..n).rev() {
            let mut or_val = 0;
            for j in 0..32 {
                if nums[i] & (1 << j) != 0 {
                    or_val |= 1 << j;
                    max_bit[j] = i;
                }
            }
            let mut max_len = 0;
            for j in 0..32 {
                if (or_val & (1 << j)) != 0 {
                    max_len = max_len.max(max_bit[j] - i + 1);
                }
            }
            result[i] = max_len;
        }

        result
    }
}