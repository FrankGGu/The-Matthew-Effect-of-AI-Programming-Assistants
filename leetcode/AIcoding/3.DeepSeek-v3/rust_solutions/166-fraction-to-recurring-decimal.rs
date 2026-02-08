use std::collections::HashMap;

impl Solution {
    pub fn fraction_to_decimal(numerator: i32, denominator: i32) -> String {
        if numerator == 0 {
            return "0".to_string();
        }

        let mut res = String::new();
        if (numerator < 0) ^ (denominator < 0) {
            res.push('-');
        }

        let num = (numerator as i64).abs();
        let den = (denominator as i64).abs();

        res.push_str(&(num / den).to_string());
        let mut rem = num % den;
        if rem == 0 {
            return res;
        }

        res.push('.');
        let mut map = HashMap::new();
        while rem != 0 {
            if let Some(&pos) = map.get(&rem) {
                res.insert(pos, '(');
                res.push(')');
                break;
            }
            map.insert(rem, res.len());
            rem *= 10;
            res.push_str(&(rem / den).to_string());
            rem %= den;
        }

        res
    }
}