impl Solution {
    pub fn split_array_same_average(a: Vec<i32>) -> bool {
        let n = a.len();
        let sum: i32 = a.iter().sum();
        let mut a = a;
        a.sort();

        for k in 1..n {
            if sum * k % n == 0 {
                let target = sum * k / n;
                if Self::can_find_subset_with_sum(&a, target, k) {
                    return true;
                }
            }
        }
        false
    }

    fn can_find_subset_with_sum(a: &[i32], target: i32, k: usize) -> bool {
        let n = a.len();
        let mut dp = vec![vec![false; target as usize + 1]; k + 1];
        dp[0][0] = true;

        for &num in a {
            for j in (1..=k).rev() {
                for s in (num..=target).rev() {
                    dp[j][s as usize] |= dp[j - 1][(s - num) as usize];
                }
            }
        }
        dp[k][target as usize]
    }
}