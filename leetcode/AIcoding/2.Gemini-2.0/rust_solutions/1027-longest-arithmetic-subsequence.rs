impl Solution {
    pub fn longest_arith_seq_length(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 2 {
            return n as i32;
        }

        let mut dp: Vec<std::collections::HashMap<i32, i32>> = vec![std::collections::HashMap::new(); n];
        let mut max_len = 2;

        for i in 1..n {
            for j in 0..i {
                let diff = nums[i] - nums[j];
                let len = match dp[j].get(&diff) {
                    Some(&l) => l + 1,
                    None => 2,
                };
                dp[i].insert(diff, len);
                max_len = max_len.max(len);
            }
        }

        max_len
    }
}