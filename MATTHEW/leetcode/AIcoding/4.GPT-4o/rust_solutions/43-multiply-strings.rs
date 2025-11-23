impl Solution {
    pub fn multiply(num1: String, num2: String) -> String {
        let len1 = num1.len();
        let len2 = num2.len();
        let mut result = vec![0; len1 + len2];

        for i in (0..len1).rev() {
            for j in (0..len2).rev() {
                let mul = (num1.as_bytes()[i] - b'0') as usize * (num2.as_bytes()[j] - b'0') as usize;
                let p1 = i + j;
                let p2 = i + j + 1;
                let sum = mul + result[p2];

                result[p2] = sum % 10;
                result[p1] += sum / 10;
            }
        }

        result.iter().skip_while(|&&x| x == 0).map(|&x| (x + b'0') as char).collect::<String>().unwrap_or("0".to_string())
    }
}