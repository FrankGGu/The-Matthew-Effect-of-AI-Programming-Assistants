impl Solution {
    pub fn min_operations(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i64> {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i] as i64;
        }
        let mut res = Vec::new();
        for q in queries {
            let q = q as i64;
            let idx = match nums.binary_search(&(q as i32)) {
                Ok(i) => i,
                Err(i) => i,
            };
            let left = q * idx as i64 - prefix[idx];
            let right = (prefix[n] - prefix[idx]) - q * (n - idx) as i64;
            res.push(left + right);
        }
        res
    }
}