impl Solution {
    pub fn multiply(num1: String, num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0".to_string();
        }

        let n1 = num1.len();
        let n2 = num2.len();
        let mut result = vec![0; n1 + n2];

        for i in (0..n1).rev() {
            for j in (0..n2).rev() {
                let digit1 = (num1.as_bytes()[i] - b'0') as i32;
                let digit2 = (num2.as_bytes()[j] - b'0') as i32;

                let product = digit1 * digit2;
                let p1 = i + j;
                let p2 = i + j + 1;

                let sum = product + result[p2];

                result[p2] = sum % 10;
                result[p1] += sum / 10;
            }
        }

        let mut s = String::new();
        let mut start = 0;
        while start < result.len() && result[start] == 0 {
            start += 1;
        }

        for i in start..result.len() {
            s.push_str(&result[i].to_string());
        }

        if s.is_empty() {
            "0".to_string()
        } else {
            s
        }
    }
}