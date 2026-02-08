impl Solution {
    pub fn multiply(num1: String, num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0".to_string();
        }

        let n1_digits: Vec<u8> = num1
            .chars()
            .rev()
            .map(|c| c.to_digit(10).unwrap() as u8)
            .collect();
        let n2_digits: Vec<u8> = num2
            .chars()
            .rev()
            .map(|c| c.to_digit(10).unwrap() as u8)
            .collect();

        let mut res = vec![0; n1_digits.len() + n2_digits.len()];

        for i in 0..n1_digits.len() {
            let mut carry = 0;
            for j in 0..n2_digits.len() {
                let product = (n1_digits[i] * n2_digits[j]) + res[i + j] + carry;
                res[i + j] = product % 10;
                carry = product / 10;
            }
            if carry > 0 {
                res[i + n2_digits.len()] += carry;
            }
        }

        let mut i = res.len() - 1;
        while i > 0 && res[i] == 0 {
            i -= 1;
        }

        res[0..=i]
            .iter()
            .rev()
            .map(|&d| (d + b'0') as char)
            .collect()
    }
}