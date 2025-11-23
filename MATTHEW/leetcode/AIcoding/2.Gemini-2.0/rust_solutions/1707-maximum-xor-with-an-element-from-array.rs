impl Solution {
    pub fn maximize_xor(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort_unstable();
        let mut ans = Vec::with_capacity(queries.len());
        for q in queries {
            let x = q[0];
            let m = q[1];
            let mut max_xor = -1;
            for &num in nums.iter().filter(|&&n| n <= m) {
                max_xor = max_xor.max(x ^ num);
            }
            ans.push(max_xor);
        }
        ans
    }
}