impl Solution {
    pub fn max_jumps(arr: Vec<i32>, d: i32) -> i32 {
        let n = arr.len();
        let mut memo = vec![0; n];
        let mut max_jumps = 0;
        for i in 0..n {
            max_jumps = max_jumps.max(Self::dfs(&arr, d as usize, i, &mut memo));
        }
        max_jumps
    }

    fn dfs(arr: &[i32], d: usize, i: usize, memo: &mut Vec<i32>) -> i32 {
        if memo[i] != 0 {
            return memo[i];
        }
        let mut max = 1;
        for j in 1..=d {
            if i + j >= arr.len() || arr[i + j] >= arr[i] {
                break;
            }
            max = max.max(1 + Self::dfs(arr, d, i + j, memo));
        }
        for j in 1..=d {
            if i < j || arr[i - j] >= arr[i] {
                break;
            }
            max = max.max(1 + Self::dfs(arr, d, i - j, memo));
        }
        memo[i] = max;
        max
    }
}