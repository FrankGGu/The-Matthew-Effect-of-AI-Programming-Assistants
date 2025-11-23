impl Solution {
    pub fn license_key_formatting(s: String, k: i32) -> String {
        let mut result = String::new();
        let mut count = 0;
        for c in s.chars().rev() {
            if c != '-' {
                if count == k {
                    result.push('-');
                    count = 0;
                }
                result.push(c.to_uppercase().next().unwrap());
                count += 1;
            }
        }
        result.chars().rev().collect()
    }
}