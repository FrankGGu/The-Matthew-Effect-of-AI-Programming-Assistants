impl Solution {
    pub fn minimize_result(expression: String) -> String {
        let plus_idx = expression.find('+').unwrap();
        let num1_str = &expression[0..plus_idx];
        let num2_str = &expression[plus_idx + 1..];

        let mut min_val = u128::MAX;
        let mut min_expr = String::new();

        for i in 0..num1_str.len() {
            for j in 0..num2_str.len() {
                let outer_left_val = if i == 0 {
                    1
                } else {
                    num1_str[0..i].parse::<u128>().unwrap()
                };

                let inner_left_val = num1_str[i..].parse::<u128>().unwrap();

                let inner_right_val = num2_str[0..j + 1].parse::<u128>().unwrap();

                let outer_right_val = if j == num2_str.len() - 1 {
                    1
                } else {
                    num2_str[j + 1..].parse::<u128>().unwrap()
                };

                let current_val = outer_left_val * (inner_left_val + inner_right_val) * outer_right_val;

                if current_val < min_val {
                    min_val = current_val;
                    let outer_left_part = &num1_str[0..i];
                    let inner_left_part = &num1_str[i..];
                    let inner_right_part = &num2_str[0..j + 1];
                    let outer_right_part = &num2_str[j + 1..];

                    min_expr = format!(
                        "{}({}+{}){}",
                        outer_left_part, inner_left_part, inner_right_part, outer_right_part
                    );
                }
            }
        }

        min_expr
    }
}