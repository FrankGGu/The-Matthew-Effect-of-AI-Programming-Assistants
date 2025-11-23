impl Solution {
    pub fn num_of_ways(nums: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let n = nums.len();
        let mut comb = vec![vec![1; n + 1]; n + 1];
        for i in 2..=n {
            for j in 1..i {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % MOD;
            }
        }
        let result = (Self::dfs(&nums, &comb) as i64 - 1;
        (result % MOD) as i32
    }

    fn dfs(nums: &[i32], comb: &Vec<Vec<i64>>) -> i64 {
        if nums.len() <= 2 {
            return 1;
        }
        let root = nums[0];
        let left: Vec<i32> = nums.iter().filter(|&&x| x < root).cloned().collect();
        let right: Vec<i32> = nums.iter().filter(|&&x| x > root).cloned().collect();
        let left_ways = Self::dfs(&left, comb);
        let right_ways = Self::dfs(&right, comb);
        let total = left.len() + right.len();
        let left_len = left.len();
        let ways = comb[total][left_len] % MOD;
        ways * left_ways % MOD * right_ways % MOD
    }
}