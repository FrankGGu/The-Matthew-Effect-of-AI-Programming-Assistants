impl Solution {
    pub fn xor_subarray(nums: Vec<i32>, k: i32, xor: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;
        let mut ans: i64 = 0;
        let mut prefix_xor: Vec<i32> = vec![0; n + 1];
        for i in 0..n {
            prefix_xor[i + 1] = prefix_xor[i] ^ nums[i];
        }

        for i in 0..=n - k {
            ans += ((prefix_xor[i + k] ^ prefix_xor[i]) & xor) as i64;
        }

        ans
    }
}