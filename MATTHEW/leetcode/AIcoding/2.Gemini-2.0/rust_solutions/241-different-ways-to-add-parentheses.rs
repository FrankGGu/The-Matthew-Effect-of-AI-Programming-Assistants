impl Solution {
    pub fn diff_ways_to_compute(expression: String) -> Vec<i32> {
        let mut nums = Vec::new();
        let mut ops = Vec::new();
        let mut num = 0;
        for c in expression.chars() {
            if c.is_digit(10) {
                num = num * 10 + c.to_digit(10).unwrap() as i32;
            } else {
                nums.push(num);
                num = 0;
                ops.push(c);
            }
        }
        nums.push(num);

        let n = nums.len();
        let mut dp = vec![vec![Vec::new(); n]; n];

        for i in 0..n {
            dp[i][i].push(nums[i]);
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                for k in i..j {
                    for &left in &dp[i][k] {
                        for &right in &dp[k + 1][j] {
                            let op = ops[k];
                            match op {
                                '+' => dp[i][j].push(left + right),
                                '-' => dp[i][j].push(left - right),
                                '*' => dp[i][j].push(left * right),
                                _ => {}
                            }
                        }
                    }
                }
            }
        }

        dp[0][n - 1].clone()
    }
}