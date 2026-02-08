struct Solution;

impl Solution {
    pub fn solve_equation(equation: String) -> String {
        let parts: Vec<&str> = equation.split('=').collect();
        let left_side_str = parts[0];
        let right_side_str = parts[1];

        let (left_coeff_x, left_constant) = Self::parse_side(left_side_str);
        let (right_coeff_x, right_constant) = Self::parse_side(right_side_str);

        // Move all x terms to the left, and constants to the right
        // (left_coeff_x - right_coeff_x) * x = (right_constant - left_constant)
        let total_coeff_x = left_coeff_x - right_coeff_x;
        let total_constant = right_constant - left_constant;

        if total_coeff_x == 0 {
            if total_constant == 0 {
                "Infinite solutions".to_string()
            } else {
                "No solution".to_string()
            }
        } else {
            format!("x={}", total_constant / total_coeff_x)
        }
    }

    fn parse_side(side_str: &str) -> (i32, i32) {
        let mut coeff_x = 0;
        let mut constant = 0;

        // Preprocess the string to make splitting by '+' easier.
        // Example: "x+5-3x" becomes "+x+5+-3x"
        let mut s = String::from(side_str);
        if !s.starts_with('+') && !s.starts_with('-') {
            s.insert(0, '+');
        }
        s = s.replace("-", "+-");

        for term_str in s.split('+') {
            if term_str.is_empty() {
                continue;
            }

            if term_str.contains('x') {
                let num_str = term_str.trim_end_matches('x');
                let val = if num_str.is_empty() {
                    1 // Case like "x" or "+x"
                } else if num_str == "-" {
                    -1 // Case like "-x"
                } else {
                    num_str.parse::<i32>().unwrap()
                };
                coeff_x += val;
            } else {
                let val = term_str.parse::<i32>().unwrap();
                constant += val;
            }
        }

        (coeff_x, constant)
    }
}