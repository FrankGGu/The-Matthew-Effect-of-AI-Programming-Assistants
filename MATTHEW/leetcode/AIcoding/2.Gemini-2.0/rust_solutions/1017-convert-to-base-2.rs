impl Solution {
    pub fn base_neg2(n: i32) -> String {
        if n == 0 {
            return "0".to_string();
        }
        let mut num = n;
        let mut result = String::new();
        while num != 0 {
            let rem = num % -2;
            num /= -2;
            if rem < 0 {
                num += 1;
                result.push_str("1");
            } else {
                result.push_str(&rem.to_string());
            }
        }
        result.chars().rev().collect()
    }
}