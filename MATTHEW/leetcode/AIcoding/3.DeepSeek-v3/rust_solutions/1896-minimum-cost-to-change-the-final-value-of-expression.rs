use std::collections::VecDeque;

impl Solution {
    pub fn min_operations_to_flip(expression: String) -> i32 {
        let expr: Vec<char> = expression.chars().collect();
        let n = expr.len();
        let mut stack = Vec::new();
        let mut dp = vec![vec![(0, 0); n]; n];
        let mut pos = vec![0; n];

        for i in 0..n {
            if expr[i] == '(' {
                stack.push(i);
            } else if expr[i] == ')' {
                pos[stack.pop().unwrap()] = i;
            }
        }

        Self::dfs(&expr, 0, n - 1, &pos, &mut dp)
    }

    fn dfs(expr: &[char], l: usize, r: usize, pos: &[usize], dp: &mut Vec<Vec<(i32, i32)>>) -> i32 {
        if dp[l][r] != (0, 0) {
            return if dp[l][r].0 < dp[l][r].1 { dp[l][r].0 } else { dp[l][r].1 };
        }

        if l == r {
            let val = expr[l] as i32 - '0' as i32;
            dp[l][r] = (val ^ 1, val);
            return if val == 0 { 1 } else { 1 };
        }

        let mut k = l;
        if expr[l] == '(' {
            k = pos[l];
            if k == r {
                return Self::dfs(expr, l + 1, r - 1, pos, dp);
            }
        }

        let left = Self::dfs(expr, l, k, pos, dp);
        let (l0, l1) = dp[l][k];
        let right = Self::dfs(expr, k + 1, r, pos, dp);
        let (r0, r1) = dp[k + 1][r];

        let mut res0 = i32::MAX;
        let mut res1 = i32::MAX;

        if k + 1 < expr.len() && expr[k + 1] == '&' {
            res0 = res0.min(l0 + r0).min(l0 + r1).min(l1 + r0);
            res1 = l1 + r1;
        } else if k + 1 < expr.len() && expr[k + 1] == '|' {
            res0 = l0 + r0;
            res1 = res1.min(l1 + r1).min(l0 + r1).min(l1 + r0);
        }

        res0 = res0.min(l0 + r0 + 1);
        res1 = res1.min(l1 + r1 + 1);

        dp[l][r] = (res0, res1);

        if res0 < res1 { res0 } else { res1 }
    }
}