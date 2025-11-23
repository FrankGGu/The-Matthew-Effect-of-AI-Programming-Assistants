impl Solution {
    pub fn score_of_students(s: String, answers: Vec<i32>) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut dp = vec![vec![std::collections::HashSet::new(); n]; n];

        for i in (0..n).step_by(2) {
            dp[i][i].insert((s[i] - b'0') as i32);
        }

        for len in (3..=n).step_by(2) {
            for i in (0..=n - len).step_by(2) {
                let j = i + len - 1;
                let mut set = std::collections::HashSet::new();
                for k in (i + 1..j).step_by(2) {
                    let left = &dp[i][k - 1];
                    let right = &dp[k + 1][j];
                    for &a in left {
                        for &b in right {
                            let res = if s[k] == b'+' { a + b } else { a * b };
                            if res <= 1000 {
                                set.insert(res);
                            }
                        }
                    }
                }
                dp[i][j] = set;
            }
        }

        let correct = Self::calculate(&s);
        let possible = &dp[0][n - 1];
        let mut score = 0;
        for ans in answers {
            if ans == correct {
                score += 5;
            } else if possible.contains(&ans) {
                score += 2;
            }
        }
        score
    }

    fn calculate(s: &[u8]) -> i32 {
        let mut stack = Vec::new();
        let mut num = 0;
        let mut op = b'+';

        for i in 0..s.len() {
            let c = s[i];
            if c.is_ascii_digit() {
                num = num * 10 + (c - b'0') as i32;
            }
            if !c.is_ascii_digit() || i == s.len() - 1 {
                match op {
                    b'+' => stack.push(num),
                    b'*' => {
                        let top = stack.pop().unwrap();
                        stack.push(top * num);
                    },
                    _ => (),
                }
                op = c;
                num = 0;
            }
        }
        stack.iter().sum()
    }
}