impl Solution {
    pub fn sum_indices_with_k_set_bits(nums: Vec<i32>, k: i32) -> i32 {
        let mut sum = 0;
        for (i, &num) in nums.iter().enumerate() {
            if i.count_ones() == k as u32 {
                sum += num;
            }
        }
        sum
    }
}