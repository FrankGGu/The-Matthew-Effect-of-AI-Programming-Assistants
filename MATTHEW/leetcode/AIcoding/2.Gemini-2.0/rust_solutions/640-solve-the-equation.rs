impl Solution {
    pub fn solve_equation(equation: String) -> String {
        let mut left_sign = 1;
        let mut coeff = 0;
        let mut const_term = 0;
        let mut num = 0;
        let mut sign = 1;

        for c in equation.chars() {
            match c {
                '+' => {
                    const_term += sign * num;
                    num = 0;
                    sign = 1;
                }
                '-' => {
                    const_term += sign * num;
                    num = 0;
                    sign = -1;
                }
                'x' => {
                    if num == 0 {
                        coeff += left_sign * sign * 1;
                    } else {
                        coeff += left_sign * sign * num;
                    }
                    num = 0;
                    sign = 1;
                }
                '=' => {
                    const_term += sign * num;
                    num = 0;
                    left_sign = -1;
                    sign = 1;
                }
                _ => {
                    num = num * 10 + (c as i32 - '0' as i32) as i32;
                }
            }
        }

        const_term += sign * num;

        if coeff == 0 {
            if const_term == 0 {
                return "Infinite solutions".to_string();
            } else {
                return "No solution".to_string();
            }
        } else {
            let ans = -const_term / coeff;
            return format!("x={}", ans);
        }
    }
}