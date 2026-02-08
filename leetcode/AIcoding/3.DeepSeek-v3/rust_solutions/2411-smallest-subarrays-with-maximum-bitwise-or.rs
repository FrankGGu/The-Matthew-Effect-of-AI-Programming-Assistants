impl Solution {
    pub fn smallest_subarrays(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut res = vec![1; n];
        let mut bits = vec![0; 32];

        for i in (0..n).rev() {
            for j in 0..32 {
                if (nums[i] >> j) & 1 == 1 {
                    bits[j] = i;
                }
            }
            let max_bit_pos = bits.iter().max().unwrap();
            res[i] = (max_bit_pos - i + 1) as i32;
        }
        res
    }
}