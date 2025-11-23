impl Solution {
    pub fn min_cost(expr: String) -> i32 {
        let n = expr.len();
        let mut dp = vec![vec![0; n]; n];
        let mut sign = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = if expr.as_bytes()[i] == b'T' { 0 } else { 1 };
            for j in 0..i {
                if expr.as_bytes()[j] == b'&' {
                    sign[j][i] = 1;
                } else if expr.as_bytes()[j] == b'|' {
                    sign[j][i] = 2;
                } else if expr.as_bytes()[j] == b'^' {
                    sign[j][i] = 3;
                }
            }
        }

        for len in 2..=n {
            for i in 0..n - len + 1 {
                let j = i + len - 1;
                for k in (i..j).step_by(2) {
                    let op = sign[i][k];
                    let left = dp[i][k - 1];
                    let right = dp[k + 1][j];
                    let total = left + right;

                    match op {
                        1 => {
                            dp[i][j] = total - (if left > 0 && right > 0 { 1 } else { 0 });
                        }
                        2 => {
                            dp[i][j] = total - (if left == 0 || right == 0 { 1 } else { 0 });
                        }
                        3 => {
                            dp[i][j] = total - (if left != right { 1 } else { 0 });
                        }
                        _ => {}
                    }
                }
            }
        }

        dp[0][n - 1]
    }
}