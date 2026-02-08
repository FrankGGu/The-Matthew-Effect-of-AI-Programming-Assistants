impl Solution {
    pub fn encrypt(num: i32) -> String {
        let mut result = String::new();
        let mut n = num;
        while n > 0 {
            result.push((b'a' + (n % 26) as u8) as char);
            n /= 26;
        }
        result.chars().rev().collect()
    }
}