impl Solution {
    pub fn convert_to_base7(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }
        let mut n = num;
        let mut base7 = String::new();
        let is_negative = n < 0;
        if is_negative {
            n = -n;
        }
        while n > 0 {
            base7.push_str(&(n % 7).to_string());
            n /= 7;
        }
        if is_negative {
            base7.push('-');
        }
        base7.chars().rev().collect()
    }
}