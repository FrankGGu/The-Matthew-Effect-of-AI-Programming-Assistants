impl Solution {
    pub fn base_neg2(n: i32) -> String {
        if n == 0 {
            return "0".to_string();
        }

        let mut n = n;
        let mut result_chars = Vec::new();

        while n != 0 {
            let mut remainder = n % 2;
            if remainder < 0 {
                remainder += 2;
            }

            result_chars.push(std::char::from_digit(remainder as u32, 10).unwrap());

            n = (n - remainder) / (-2);
        }

        result_chars.into_iter().rev().collect()
    }
}