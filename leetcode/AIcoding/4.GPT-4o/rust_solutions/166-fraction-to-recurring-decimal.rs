impl Solution {
    pub fn fraction_to_decimal(numerator: i32, denominator: i32) -> String {
        if numerator == 0 {
            return "0".to_string();
        }

        let mut result = String::new();
        if (numerator < 0) ^ (denominator < 0) {
            result.push('-');
        }

        let num = numerator.abs() as i64;
        let den = denominator.abs() as i64;

        result.push_str(&(num / den).to_string());
        let mut remainder = num % den;

        if remainder == 0 {
            return result;
        }

        result.push('.');
        let mut map = std::collections::HashMap::new();
        let mut index = result.len();

        while remainder != 0 {
            if let Some(pos) = map.get(&remainder) {
                result.insert(*pos, '(');
                result.push(')');
                return result;
            }
            map.insert(remainder, index);
            remainder *= 10;
            result.push_str(&(remainder / den).to_string());
            remainder %= den;
            index += 1;
        }

        result
    }
}