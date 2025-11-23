impl Solution {
    pub fn get_averages(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut res = vec![-1; n];
        if 2 * k + 1 > n {
            return res;
        }
        let mut prefix = vec![0 as i64; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i] as i64;
        }
        for i in k..n - k {
            let sum = prefix[i + k + 1] - prefix[i - k];
            res[i] = (sum / (2 * k as i64 + 1)) as i32;
        }
        res
    }
}