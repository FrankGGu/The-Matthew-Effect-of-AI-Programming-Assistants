impl Solution {
    pub fn complex_number_multiply(num1: String, num2: String) -> String {
        let parse_complex = |s: String| -> (i32, i32) {
            let parts: Vec<&str> = s.split('+').collect();
            let real = parts[0].parse::<i32>().unwrap();
            let imaginary = parts[1].trim_end_matches('i').parse::<i32>().unwrap();
            (real, imaginary)
        };

        let (a, b) = parse_complex(num1);
        let (c, d) = parse_complex(num2);

        let real_part = a * c - b * d;
        let imaginary_part = a * d + b * c;

        format!("{}+{}i", real_part, imaginary_part)
    }
}