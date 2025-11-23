impl Solution {
    pub fn minimize_result(expression: String) -> String {
        let parts: Vec<&str> = expression.split('+').collect();
        let a = parts[0];
        let b = parts[1];
        let mut min_val = i32::MAX;
        let mut min_str = String::new();

        for i in 0..a.len() {
            for j in 1..=b.len() {
                let left = &a[..i];
                let mid_a = &a[i..];
                let mid_b = &b[..j];
                let right = &b[j..];

                let left_val = if left.is_empty() { 1 } else { left.parse::<i32>().unwrap() };
                let mid_a_val = mid_a.parse::<i32>().unwrap();
                let mid_b_val = mid_b.parse::<i32>().unwrap();
                let right_val = if right.is_empty() { 1 } else { right.parse::<i32>().unwrap() };

                let current_val = left_val * (mid_a_val + mid_b_val) * right_val;

                if current_val < min_val {
                    min_val = current_val;
                    let mut current_str = String::new();
                    if !left.is_empty() {
                        current_str.push_str(left);
                    }
                    current_str.push('(');
                    current_str.push_str(mid_a);
                    current_str.push('+');
                    current_str.push_str(mid_b);
                    current_str.push(')');
                    if !right.is_empty() {
                        current_str.push_str(right);
                    }
                    min_str = current_str;
                }
            }
        }

        min_str
    }
}