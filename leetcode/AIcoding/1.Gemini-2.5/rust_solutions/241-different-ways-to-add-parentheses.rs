impl Solution {
    pub fn diff_ways_to_add_parentheses(expression: String) -> Vec<i32> {
        let mut result = Vec::new();
        let mut is_number = true;

        for (i, c) in expression.chars().enumerate() {
            if c == '+' || c == '-' || c == '*' {
                is_number = false;
                let left_parts = Solution::diff_ways_to_add_parentheses(expression[0..i].to_string());
                let right_parts = Solution::diff_ways_to_add_parentheses(expression[i + 1..].to_string());

                for &l_val in &left_parts {
                    for &r_val in &right_parts {
                        match c {
                            '+' => result.push(l_val + r_val),
                            '-' => result.push(l_val - r_val),
                            '*' => result.push(l_val * r_val),
                            _ => unreachable!(),
                        }
                    }
                }
            }
        }

        if is_number {
            result.push(expression.parse::<i32>().unwrap());
        }

        result
    }
}