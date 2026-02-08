impl Solution {
    pub fn smallest_number(num: i64) -> i64 {
        if num == 0 {
            return 0;
        }
        let is_negative = num < 0;
        let mut digits: Vec<char> = num.abs().to_string().chars().collect();
        if is_negative {
            digits.sort_by(|a, b| b.cmp(a));
            let s: String = digits.into_iter().collect();
            -s.parse::<i64>().unwrap()
        } else {
            digits.sort();
            let mut first_non_zero = 0;
            while first_non_zero < digits.len() && digits[first_non_zero] == '0' {
                first_non_zero += 1;
            }
            if first_non_zero < digits.len() {
                digits.swap(0, first_non_zero);
            }
            let s: String = digits.into_iter().collect();
            s.parse::<i64>().unwrap()
        }
    }
}