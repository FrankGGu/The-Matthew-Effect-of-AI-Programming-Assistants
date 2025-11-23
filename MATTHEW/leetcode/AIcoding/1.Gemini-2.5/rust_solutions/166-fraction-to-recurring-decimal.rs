impl Solution {
    pub fn fraction_to_decimal(numerator: i32, denominator: i32) -> String {
        if numerator == 0 {
            return "0".to_string();
        }

        let mut s = String::new();
        let num = numerator as i64;
        let den = denominator as i64;

        if (num < 0) ^ (den < 0) {
            s.push('-');
        }

        let mut abs_num = num.abs();
        let abs_den = den.abs();

        s.push_str(&(abs_num / abs_den).to_string());
        abs_num %= abs_den;

        if abs_num == 0 {
            return s;
        }

        s.push('.');
        let mut map: std::collections::HashMap<i64, usize> = std::collections::HashMap::new();

        while abs_num != 0 {
            if let Some(&idx) = map.get(&abs_num) {
                s.insert(idx, '(');
                s.push(')');
                return s;
            }

            map.insert(abs_num, s.len());

            abs_num *= 10;
            s.push_str(&(abs_num / abs_den).to_string());
            abs_num %= abs_den;
        }

        s
    }
}