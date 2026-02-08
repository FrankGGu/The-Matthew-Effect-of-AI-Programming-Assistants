impl Solution {
    pub fn partition(s: String) -> Vec<Vec<String>> {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut dp = vec![vec![false; n]; n];
        let mut res = Vec::new();
        let mut path = Vec::new();

        for i in (0..n).rev() {
            for j in i..n {
                if s_bytes[i] == s_bytes[j] && (j - i <= 2 || dp[i + 1][j - 1]) {
                    dp[i][j] = true;
                }
            }
        }

        fn backtrack(s: &[u8], start: usize, dp: &Vec<Vec<bool>>, path: &mut Vec<String>, res: &mut Vec<Vec<String>>) {
            if start == s.len() {
                res.push(path.clone());
                return;
            }

            for i in start..s.len() {
                if dp[start][i] {
                    path.push(String::from_utf8(s[start..=i].to_vec()).unwrap());
                    backtrack(s, i + 1, dp, path, res);
                    path.pop();
                }
            }
        }

        backtrack(s_bytes, 0, &dp, &mut path, &mut res);
        res
    }
}