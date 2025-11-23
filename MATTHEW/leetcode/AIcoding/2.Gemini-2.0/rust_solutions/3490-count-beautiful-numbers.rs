impl Solution {
    pub fn count_beautiful_numbers(n: i64) -> i64 {
        let s = n.to_string();
        let len = s.len();
        let mut dp = vec![vec![0; 41]; len + 1];
        dp[0][0] = 1;

        for i in 0..len {
            let digit = s.chars().nth(i).unwrap().to_digit(10).unwrap() as i64;
            for j in 0..41 {
                if dp[i][j] == 0 {
                    continue;
                }

                for d in 0..=9 {
                    let new_j = j + d;
                    if new_j <= 40 {
                        if d < digit {
                            dp[i + 1][new_j] += dp[i][j];
                        } else if d == digit {
                            dp[i + 1][new_j] += dp[i][j];
                        }
                    }
                }
            }
        }

        let mut ans = 0;
        for j in 1..41 {
            if j % Self::lcm(1, 2 * 3 * 5 * 7) == 0 {
                ans += dp[len][j];
            }
        }

        let mut sum = 0;
        let mut num = n;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        if sum % Self::lcm(1, 2 * 3 * 5 * 7) == 0 {
            ans += 1;
        }

        ans - 1
    }

    fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    fn lcm(a: i64, b: i64) -> i64 {
        a * b / Self::gcd(a, b)
    }
}