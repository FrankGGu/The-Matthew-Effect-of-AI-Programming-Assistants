impl Solution {
    pub fn convert_to_base7(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }
        let mut num = num;
        let mut res = String::new();
        let is_negative = num < 0;
        if is_negative {
            num = -num;
        }
        while num > 0 {
            res.push_str(&(num % 7).to_string());
            num /= 7;
        }
        if is_negative {
            res.push('-');
        }
        res.chars().rev().collect()
    }
}