impl Solution {
    pub fn sum_indices_with_k_set_bits(nums: Vec<i32>, k: i32) -> i32 {
        let mut sum = 0;
        for i in 0..nums.len() {
            let mut count = 0;
            let mut num = i as i32;
            while num > 0 {
                count += num & 1;
                num >>= 1;
            }
            if count == k {
                sum += nums[i];
            }
        }
        sum
    }
}