const MOD: i32 = 1_000_000_007;

struct Solution {
    memo: Vec<Vec<Vec<Vec<i32>>>>,
    s_chars: Vec<char>,
    min_sum: i32,
    max_sum: i32,
}

impl Solution {
    fn new() -> Self {
        Solution {
            memo: Vec::new(),
            s_chars: Vec::new(),
            min_sum: 0,
            max_sum: 0,
        }
    }

    fn solve(&mut self, idx: usize, current_sum: i32, tight: bool, is_started: bool) -> i32 {
        if idx == self.s_chars.len() {
            if is_started {
                return if current_sum >= self.min_sum && current_sum <= self.max_sum { 1 } else { 0 };
            } else {
                return if 0 >= self.min_sum && 0 <= self.max_sum { 1 } else { 0 };
            }
        }

        let tight_idx = tight as usize;
        let started_idx = is_started as usize;
        if self.memo[idx][current_sum as usize][tight_idx][started_idx] != -1 {
            return self.memo[idx][current_sum as usize][tight_idx][started_idx];
        }

        let mut ans = 0;
        let upper_bound = if tight {
            self.s_chars[idx].to_digit(10).unwrap() as i32
        } else {
            9
        };

        for digit in 0..=upper_bound {
            if !is_started && digit == 0 {
                ans = (ans + self.solve(idx + 1, current_sum, tight && (digit == upper_bound), false)) % MOD;
            } else {
                if current_sum + digit > self.max_sum {
                    continue;
                }
                ans = (ans + self.solve(idx + 1, current_sum + digit, tight && (digit == upper_bound), true)) % MOD;
            }
        }

        self.memo[idx][current_sum as usize][tight_idx][started_idx] = ans;
        ans
    }

    fn count_less_than_or_equal_to(&mut self, s: String, min_sum: i32, max_sum: i32) -> i32 {
        self.s_chars = s.chars().collect();
        self.min_sum = min_sum;
        self.max_sum = max_sum;

        let n = self.s_chars.len();
        self.memo = vec![vec![vec![vec![-1; 2]; 2]; (max_sum + 1) as usize]; n + 1];

        self.solve(0, 0, true, false)
    }

    pub fn count_of_integers(num1: String, num2: String, min_sum: i32, max_sum: i32) -> i32 {
        let mut solver = Solution::new();
        let ans2 = solver.count_less_than_or_equal_to(num2, min_sum, max_sum);

        let mut num1_chars: Vec<char> = num1.chars().collect();
        let mut i = num1_chars.len() as i32 - 1;
        while i >= 0 {
            if num1_chars[i as usize] == '0' {
                num1_chars[i as usize] = '9';
            } else {
                num1_chars[i as usize] = std::char::from_digit(num1_chars[i as usize].to_digit(10).unwrap() - 1, 10).unwrap();
                break;
            }
            i -= 1;
        }

        let num1_minus_1_str = if i < 0 {
            "0".to_string()
        } else {
            num1_chars.iter().skip_while(|&&c| c == '0').collect::<String>()
        };

        let ans1_minus_1 = if num1_minus_1_str.is_empty() {
            solver = Solution::new();
            solver.count_less_than_or_equal_to("0".to_string(), min_sum, max_sum)
        } else {
            solver = Solution::new();
            solver.count_less_than_or_equal_to(num1_minus_1_str, min_sum, max_sum)
        };

        let result = (ans2 - ans1_minus_1 + MOD) % MOD;
        result
    }
}