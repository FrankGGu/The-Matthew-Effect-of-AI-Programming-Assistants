impl Solution {
    fn parse_complex(num_str: &str) -> (i32, i32) {
        let mut real_part_end_idx = 0;
        for (idx, c) in num_str.chars().enumerate() {
            if idx > 0 && (c == '+' || c == '-') {
                if num_str.chars().nth(idx - 1).unwrap().is_ascii_digit() {
                    real_part_end_idx = idx;
                    break;
                }
            }
        }

        let real_str = &num_str[0..real_part_end_idx];
        let imag_str_with_i = &num_str[real_part_end_idx..];
        let imag_str = &imag_str_with_i[0..imag_str_with_i.len() - 1];

        let real = real_str.parse::<i32>().unwrap();
        let imag = imag_str.parse::<i32>().unwrap();

        (real, imag)
    }

    pub fn complex_number_multiply(num1: String, num2: String) -> String {
        let (r1, i1) = Self::parse_complex(&num1);
        let (r2, i2) = Self::parse_complex(&num2);

        let result_real = r1 * r2 - i1 * i2;
        let result_imag = r1 * i2 + i1 * r2;

        format!("{}+{}i", result_real, result_imag)
    }
}