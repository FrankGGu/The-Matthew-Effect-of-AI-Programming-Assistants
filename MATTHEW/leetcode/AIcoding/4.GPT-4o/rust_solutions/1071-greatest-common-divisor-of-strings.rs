impl Solution {
    pub fn gcd_of_strings(str1: String, str2: String) -> String {
        if str1 + &str2 != str2 + &str1 {
            return "".to_string();
        }
        let gcd_length = Self::gcd(str1.len(), str2.len());
        str1[..gcd_length].to_string()
    }

    fn gcd(a: usize, b: usize) -> usize {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}