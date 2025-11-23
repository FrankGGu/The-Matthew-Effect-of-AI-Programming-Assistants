struct Solution;

impl Solution {
    pub fn solve_equation(equation: String) -> String {
        let mut left = 0;
        let mut right = 0;
        let mut i = 0;
        let mut sign = 1;
        let chars: Vec<char> = equation.chars().collect();
        let mut n = chars.len();

        while i < n {
            if chars[i] == '=' {
                i += 1;
                sign = -1;
                continue;
            }

            let mut num = 0;
            let mut is_num = false;
            let mut coeff = 1;

            if chars[i] == '+' || chars[i] == '-' {
                if chars[i] == '-' {
                    sign *= -1;
                }
                i += 1;
            }

            while i < n && chars[i].is_digit(10) {
                num = num * 10 + (chars[i] as u8 - b'0') as i32;
                is_num = true;
                i += 1;
            }

            if i < n && chars[i] == 'x' {
                if !is_num {
                    num = 1;
                }
                if sign == 1 {
                    left += num;
                } else {
                    right += num;
                }
                i += 1;
            } else {
                if sign == 1 {
                    left += num;
                } else {
                    right += num;
                }
            }
        }

        if left == right {
            return "Infinite solutions".to_string();
        } else if left == 0 {
            return "No solution".to_string();
        } else {
            let x = (right - left) / left;
            return format!("x={}", x);
        }
    }
}