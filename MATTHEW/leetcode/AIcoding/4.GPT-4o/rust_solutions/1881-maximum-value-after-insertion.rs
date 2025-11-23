impl Solution {
    pub fn max_value(n: String, x: char) -> String {
        let mut result = String::new();
        let mut inserted = false;

        if n.chars().nth(0).unwrap() == '-' {
            result.push('-');
            for c in n.chars().skip(1) {
                if !inserted && c.to_digit(10).unwrap() > x.to_digit(10).unwrap() {
                    result.push(x);
                    inserted = true;
                }
                result.push(c);
            }
            if !inserted {
                result.push(x);
            }
        } else {
            for c in n.chars() {
                if !inserted && c.to_digit(10).unwrap() < x.to_digit(10).unwrap() {
                    result.push(x);
                    inserted = true;
                }
                result.push(c);
            }
            if !inserted {
                result.push(x);
            }
        }

        result
    }
}