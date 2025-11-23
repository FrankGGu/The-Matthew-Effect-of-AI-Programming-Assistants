struct Solution;

impl Solution {
    fn parse_rational(s: &str) -> f64 {
        let mut builder = String::new();

        let dot_idx = s.find('.');
        let paren_idx = s.find('(');

        if let Some(p_idx) = paren_idx {
            // Case with repeating decimal part, e.g., "1.2(34)"
            // According to problem constraints, if '(' is present, '.' must also be present.
            let d_idx = dot_idx.unwrap(); 

            let integer_part = &s[..d_idx];
            let non_repeating_part = &s[d_idx + 1 .. p_idx];
            let repeating_part = &s[p_idx + 1 .. s.len() - 1]; // Exclude '(' and ')'

            builder.push_str(integer_part);
            builder.push('.'); 
            builder.push_str(non_repeating_part);

            // Append the repeating part multiple times to ensure sufficient precision
            // for f64 comparison. f64 typically has about 15-17 decimal digits of precision.
            // Repeating the pattern 20 times is more than enough for the given constraints.
            for _ in 0..20 { 
                builder.push_str(repeating_part);
            }
        } else {
            // Case without repeating decimal part (integer or non-repeating decimal)
            // e.g., "0", "123", "0.5", "1.25", "1."
            builder.push_str(s);
        }

        // Parse the constructed string into an f64.
        // unwrap() is safe as problem guarantees valid input format.
        builder.parse::<f64>().unwrap()
    }

    pub fn is_rational_equal(s: String, t: String) -> bool {
        let val_s = Self::parse_rational(&s);
        let val_t = Self::parse_rational(&t);

        // Compare floating-point numbers using a small epsilon to account for
        // potential precision differences.
        (val_s - val_t).abs() < 1e-9 
    }
}