impl Solution {
    pub fn min_equal_sum(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let sum1: i32 = arr1.iter().sum();
        let sum2: i32 = arr2.iter().sum();
        let mut sum = sum1 + sum2;

        if sum % 2 != 0 {
            return -1;
        }

        let target = sum / 2;
        let mut dp = vec![false; (target + 1) as usize];
        dp[0] = true;

        for &num in arr1.iter().chain(arr2.iter()) {
            for j in (num..=target).rev() {
                dp[j as usize] |= dp[(j - num) as usize];
            }
        }

        if dp[target as usize] {
            return target;
        }

        -1
    }
}