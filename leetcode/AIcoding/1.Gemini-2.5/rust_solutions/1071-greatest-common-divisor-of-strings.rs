impl Solution {
    pub fn gcd_of_strings(str1: String, str2: String) -> String {
        if str1.clone() + &str2 != str2.clone() + &str1 {
            return "".to_string();
        }

        fn gcd(a: usize, b: usize) -> usize {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        let len1 = str1.len();
        let len2 = str2.len();
        let common_divisor_len = gcd(len1, len2);

        str1[0..common_divisor_len].to_string()
    }
}