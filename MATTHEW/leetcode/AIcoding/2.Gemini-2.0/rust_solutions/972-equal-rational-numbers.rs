impl Solution {
    pub fn is_rational_equal(s: String, t: String) -> bool {
        fn to_float(s: &str) -> f64 {
            if s.contains('(') {
                let mut parts = s.split('(');
                let integer_part = parts.next().unwrap();
                let repeating_part = parts.next().unwrap().trim_end_matches(')');

                let mut num = integer_part.parse::<f64>().unwrap();
                let repeating_value = repeating_part.parse::<f64>().unwrap();
                let repeating_length = repeating_part.len();

                num += repeating_value / (10f64.powi(integer_part.len() as i32) * (1f64 - 10f64.powi(-(repeating_length as i32))));
                num
            } else {
                s.parse::<f64>().unwrap()
            }
        }
        (to_float(&s) - to_float(&t)).abs() < 1e-12
    }
}