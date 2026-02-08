impl Solution {
    pub fn minimize_result(expression: String) -> String {
        let plus_pos = expression.find('+').unwrap();
        let left_part = &expression[..plus_pos];
        let right_part = &expression[plus_pos + 1..];
        let mut min_val = i32::MAX;
        let mut result = String::new();

        for i in 0..left_part.len() {
            let a = if i == 0 {
                1
            } else {
                left_part[..i].parse::<i32>().unwrap()
            };
            let b = left_part[i..].parse::<i32>().unwrap();

            for j in 1..=right_part.len() {
                let c = right_part[..j].parse::<i32>().unwrap();
                let d = if j == right_part.len() {
                    1
                } else {
                    right_part[j..].parse::<i32>().unwrap()
                };

                let current = a * (b + c) * d;
                if current < min_val {
                    min_val = current;
                    result = format!(
                        "{}({}+{}){}",
                        &left_part[..i],
                        &left_part[i..],
                        &right_part[..j],
                        &right_part[j..]
                    );
                }
            }
        }

        result
    }
}