impl Solution {
    pub fn sum_indices_with_k_set_bits(nums: Vec<i32>, k: i32) -> i32 {
        nums.iter().enumerate().filter(|&(i, _)| i.count_ones() == k as u32).map(|(_, &num)| num).sum()
    }
}