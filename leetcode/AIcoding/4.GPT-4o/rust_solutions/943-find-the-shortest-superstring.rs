pub struct Solution;

impl Solution {
    pub fn shortest_superstring(strs: Vec<String>) -> String {
        let n = strs.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            for j in 0..n {
                if i != j {
                    dp[i][j] = Self::overlap(&strs[i], &strs[j]);
                }
            }
        }

        let mut memo = vec![-1; 1 << n];
        let mut path = vec![0; 1 << n];

        let ans = Self::find_shortest(0, (1 << n) - 1, &mut memo, &path, &strs, &dp);
        let mut res = ans.1;

        res
    }

    fn overlap(a: &String, b: &String) -> usize {
        let mut max_overlap = 0;
        let a_bytes = a.as_bytes();
        let b_bytes = b.as_bytes();
        let a_len = a.len();
        let b_len = b.len();

        for i in 1..=a_len {
            if b_bytes.starts_with(&a_bytes[a_len - i..]) {
                max_overlap = i;
            }
        }

        max_overlap
    }

    fn find_shortest(mask: usize, all_mask: usize, memo: &mut Vec<i32>, path: &mut Vec<usize>, strs: &Vec<String>, dp: &Vec<Vec<usize>>) -> (usize, String) {
        if mask == all_mask {
            return (0, String::new());
        }

        if memo[mask] != -1 {
            return (memo[mask] as usize, path[mask].to_string());
        }

        let mut min_length = usize::MAX;
        let mut best_path = 0;

        for i in 0..strs.len() {
            if mask & (1 << i) == 0 {
                let (next_length, next_path) = Self::find_shortest(mask | (1 << i), all_mask, memo, path, strs, dp);
                let length = next_length + (if next_path.is_empty() { 0 } else { dp[i][next_path.as_bytes()[0] as usize] }) + strs[i].len();

                if length < min_length {
                    min_length = length;
                    best_path = i;
                }
            }
        }

        memo[mask] = min_length as i32;
        path[mask] = best_path;
        (min_length, best_path)
    }
}