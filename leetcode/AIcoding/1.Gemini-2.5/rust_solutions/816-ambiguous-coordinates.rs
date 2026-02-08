impl Solution {
    pub fn ambiguous_coordinates(s: String) -> Vec<String> {
        let n = s.len();
        let s_inner = &s[1..n - 1];
        let inner_len = s_inner.len();
        let mut result: Vec<String> = Vec::new();

        for i in 1..inner_len {
            let x_str_part = &s_inner[0..i];
            let y_str_part = &s_inner[i..inner_len];

            let x_coords = Self::generate_valid_numbers(x_str_part);
            let y_coords = Self::generate_valid_numbers(y_str_part);

            for x_coord in x_coords.iter() {
                for y_coord in y_coords.iter() {
                    result.push(format!("({}, {})", x_coord, y_coord));
                }
            }
        }
        result
    }

    fn generate_valid_numbers(s_part: &str) -> Vec<String> {
        let mut valid_numbers: Vec<String> = Vec::new();
        let len = s_part.len();

        if len == 0 {
            return valid_numbers;
        }

        let is_valid_integer = (len == 1 || s_part.chars().next().unwrap() != '0');
        if is_valid_integer {
            valid_numbers.push(s_part.to_string());
        }

        for j in 1..len {
            let left_part = &s_part[0..j];
            let right_part = &s_part[j..len];

            let is_left_valid = (left_part.len() == 1 || left_part.chars().next().unwrap() != '0');
            let is_right_valid = (right_part.chars().last().unwrap() != '0');

            if is_left_valid && is_right_valid {
                valid_numbers.push(format!("{}.{}", left_part, right_part));
            }
        }

        valid_numbers
    }
}