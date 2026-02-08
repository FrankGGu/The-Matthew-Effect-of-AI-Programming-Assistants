impl Solution {
    pub fn sum_indices_with_k_set_bits(nums: Vec<i32>, k: i32) -> i32 {
        let mut total_sum = 0;
        for (i, &num) in nums.iter().enumerate() {
            if (i as i32).count_ones() == k {
                total_sum += num;
            }
        }
        total_sum
    }
}