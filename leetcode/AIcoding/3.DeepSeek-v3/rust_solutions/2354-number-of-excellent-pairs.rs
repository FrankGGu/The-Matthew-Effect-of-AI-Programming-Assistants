impl Solution {
    pub fn count_excellent_pairs(nums: Vec<i32>, k: i32) -> i64 {
        use std::collections::HashSet;
        let unique_nums: HashSet<i32> = nums.into_iter().collect();
        let mut bit_counts = vec![0; 32];
        for &num in &unique_nums {
            bit_counts[num.count_ones() as usize] += 1;
        }
        let mut res = 0i64;
        for i in 0..32 {
            for j in 0..32 {
                if i + j >= k as usize {
                    res += bit_counts[i] * bit_counts[j];
                }
            }
        }
        res
    }
}