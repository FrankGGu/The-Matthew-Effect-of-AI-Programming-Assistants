impl Solution {
    pub fn sum_subseq_widths(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let modulo: i64 = 1_000_000_007;
        let mut nums = nums;
        nums.sort();
        let mut result: i64 = 0;
        let mut pow2: Vec<i64> = vec![1; n];
        for i in 1..n {
            pow2[i] = (pow2[i - 1] * 2) % modulo;
        }
        for i in 0..n {
            result = (result + (nums[i] as i64) * (pow2[i] - pow2[n - 1 - i])) % modulo;
        }
        if result < 0 {
            result += modulo;
        }
        result as i32
    }
}