impl Solution {
    pub fn partition(s: String) -> Vec<Vec<String>> {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![false; n]; n];
        let mut result: Vec<Vec<String>> = Vec::new();
        let mut current: Vec<String> = Vec::new();

        for i in 0..n {
            dp[i][i] = true;
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s_chars[i] == s_chars[j] {
                    if len == 2 || dp[i + 1][j - 1] {
                        dp[i][j] = true;
                    }
                }
            }
        }

        fn backtrack(
            s_chars: &Vec<char>,
            start: usize,
            dp: &Vec<Vec<bool>>,
            current: &mut Vec<String>,
            result: &mut Vec<Vec<String>>,
        ) {
            let n = s_chars.len();
            if start == n {
                result.push(current.clone());
                return;
            }

            for i in start..n {
                if dp[start][i] {
                    let sub: String = s_chars[start..=i].iter().collect();
                    current.push(sub);
                    backtrack(s_chars, i + 1, dp, current, result);
                    current.pop();
                }
            }
        }

        backtrack(&s_chars, 0, &dp, &mut current, &mut result);
        result
    }
}