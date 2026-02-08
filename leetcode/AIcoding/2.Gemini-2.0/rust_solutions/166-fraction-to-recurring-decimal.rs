impl Solution {
    pub fn fraction_to_decimal(numerator: i32, denominator: i32) -> String {
        if numerator == 0 {
            return "0".to_string();
        }

        let mut result = String::new();
        let mut num = numerator as i64;
        let den = denominator as i64;

        if (num > 0) != (den > 0) {
            result.push('-');
        }

        num = num.abs();
        let mut den_abs = den.abs();

        result.push_str(&(num / den_abs).to_string());

        num %= den_abs;

        if num == 0 {
            return result;
        }

        result.push('.');

        let mut map = std::collections::HashMap::new();
        let mut fractional_part = String::new();

        while num != 0 {
            if map.contains_key(&num) {
                let index = map.get(&num).unwrap();
                fractional_part.insert(*index, '(');
                fractional_part.push(')');
                result.push_str(&fractional_part);
                return result;
            }

            map.insert(num, fractional_part.len());

            num *= 10;
            fractional_part.push_str(&(num / den_abs).to_string());
            num %= den_abs;
        }

        result.push_str(&fractional_part);
        result
    }
}