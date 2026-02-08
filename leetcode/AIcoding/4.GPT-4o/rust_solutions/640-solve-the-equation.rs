impl Solution {
    pub fn solve_equation(equation: String) -> String {
        let mut lhs = vec![];
        let mut rhs = vec![];
        let parts: Vec<&str> = equation.split('=').collect();
        let left = parts[0];
        let right = parts[1];

        for part in [left, right].iter_mut() {
            let mut sign = 1;
            let mut num = 0;
            let mut x_count = 0;

            let chars: Vec<char> = part.chars().collect();
            let mut i = 0;

            while i < chars.len() {
                if chars[i] == '+' {
                    sign = 1;
                    i += 1;
                } else if chars[i] == '-' {
                    sign = -1;
                    i += 1;
                }

                num = 0;
                while i < chars.len() && chars[i].is_digit(10) {
                    num = num * 10 + (chars[i] as i32 - '0' as i32);
                    i += 1;
                }

                if i < chars.len() && chars[i] == 'x' {
                    x_count += sign * if num == 0 { 1 } else { num };
                    i += 1;
                } else if num != 0 {
                    lhs.push(sign * num);
                }
            }

            if part == &left {
                lhs.push(-x_count);
            } else {
                rhs.push(x_count);
            }
        }

        let x_coeff = lhs.iter().sum::<i32>();
        let const_coeff = rhs.iter().sum::<i32>();

        if x_coeff == 0 {
            if const_coeff == 0 {
                return "Infinite solutions".to_string();
            } else {
                return "No solution".to_string();
            }
        }

        let solution = const_coeff / x_coeff;
        format!("x={}", -solution)
    }
}