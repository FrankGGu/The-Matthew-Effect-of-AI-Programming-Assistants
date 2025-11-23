impl Solution {
    pub fn max_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut bit_counts = vec![0; 31];
        for &num in &nums {
            for i in 0..31 {
                if num & (1 << i) != 0 {
                    bit_counts[i] += 1;
                }
            }
        }
        let mut result = 0;
        let modulo = 1_000_000_007;
        for _ in 0..k {
            let mut x = 0;
            for i in 0..31 {
                if bit_counts[i] > 0 {
                    x |= 1 << i;
                    bit_counts[i] -= 1;
                }
            }
            result = (result + (x as i64 * x as i64) % modulo as i64) % modulo as i64;
        }
        result as i32
    }
}