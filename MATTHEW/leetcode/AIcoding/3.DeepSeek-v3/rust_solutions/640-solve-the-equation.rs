impl Solution {
    pub fn solve_equation(equation: String) -> String {
        let parts: Vec<&str> = equation.split('=').collect();
        let left = parts[0];
        let right = parts[1];

        fn parse(s: &str) -> (i32, i32) {
            let mut x_coeff = 0;
            let mut const_term = 0;
            let mut sign = 1;
            let mut num = 0;
            let mut has_num = false;
            let chars: Vec<char> = s.chars().collect();
            let n = chars.len();
            let mut i = 0;

            while i < n {
                if chars[i] == '+' || chars[i] == '-' {
                    if has_num {
                        const_term += sign * num;
                        num = 0;
                        has_num = false;
                    }
                    sign = if chars[i] == '+' { 1 } else { -1 };
                    i += 1;
                } else if chars[i] == 'x' {
                    x_coeff += sign * (if has_num { num } else { 1 });
                    num = 0;
                    has_num = false;
                    i += 1;
                } else {
                    has_num = true;
                    num = num * 10 + chars[i].to_digit(10).unwrap() as i32;
                    i += 1;
                }
            }
            if has_num {
                const_term += sign * num;
            }
            (x_coeff, const_term)
        }

        let (left_x, left_const) = parse(left);
        let (right_x, right_const) = parse(right);

        let total_x = left_x - right_x;
        let total_const = right_const - left_const;

        if total_x == 0 {
            if total_const == 0 {
                "Infinite solutions".to_string()
            } else {
                "No solution".to_string()
            }
        } else {
            format!("x={}", total_const / total_x)
        }
    }
}