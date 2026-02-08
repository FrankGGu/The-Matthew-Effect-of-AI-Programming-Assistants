impl Solution {
    pub fn split_array_same_average(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n <= 1 {
            return false;
        }
        let sum: i32 = nums.iter().sum();
        for k in 1..n {
            if (sum * k as i32) % (n as i32) == 0 {
                let target = (sum * k as i32) / (n as i32);
                if Self::can_partition(&nums, k, target) {
                    return true;
                }
            }
        }
        false
    }

    fn can_partition(nums: &Vec<i32>, k: usize, target: i32) -> bool {
        let n = nums.len();
        let mut dp = vec![vec![false; target as usize + 1]; k + 1];
        dp[0][0] = true;

        for &num in nums {
            for i in (1..=k).rev() {
                for j in (num as usize..=target as usize).rev() {
                    dp[i][j] = dp[i][j] || dp[i - 1][j - num as usize];
                }
            }
        }

        dp[k][target as usize]
    }
}