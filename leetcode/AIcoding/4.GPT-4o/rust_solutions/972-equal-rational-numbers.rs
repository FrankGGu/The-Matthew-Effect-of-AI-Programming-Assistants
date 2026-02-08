impl Solution {
    pub fn is_rational_equal(S: String, T: String) -> bool {
        fn to_float(s: &str) -> f64 {
            let mut parts = s.split('.');
            let integer_part = parts.next().unwrap();
            let decimal_part = parts.next().unwrap_or("");
            let mut result = integer_part.parse::<f64>().unwrap();
            if !decimal_part.is_empty() {
                result += decimal_part.parse::<f64>().unwrap() / 10f64.powi(decimal_part.len() as i32);
            }
            result
        }

        to_float(&S) == to_float(&T)
    }
}