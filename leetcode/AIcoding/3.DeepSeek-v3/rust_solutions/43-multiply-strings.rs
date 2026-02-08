impl Solution {
    pub fn multiply(num1: String, num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0".to_string();
        }

        let num1_bytes = num1.as_bytes();
        let num2_bytes = num2.as_bytes();
        let len1 = num1_bytes.len();
        let len2 = num2_bytes.len();
        let mut result = vec![0; len1 + len2];

        for i in (0..len1).rev() {
            let digit1 = num1_bytes[i] - b'0';
            for j in (0..len2).rev() {
                let digit2 = num2_bytes[j] - b'0';
                let product = digit1 * digit2 + result[i + j + 1];
                result[i + j + 1] = product % 10;
                result[i + j] += product / 10;
            }
        }

        let mut start = 0;
        while start < result.len() && result[start] == 0 {
            start += 1;
        }

        result[start..]
            .iter()
            .map(|&x| (x + b'0') as char)
            .collect()
    }
}