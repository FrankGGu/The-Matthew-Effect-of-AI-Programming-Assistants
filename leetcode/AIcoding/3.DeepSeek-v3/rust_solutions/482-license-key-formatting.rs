impl Solution {
    pub fn license_key_formatting(s: String, k: i32) -> String {
        let mut result = String::new();
        let mut count = 0;
        let s_upper = s.to_uppercase();

        for c in s_upper.chars().rev() {
            if c == '-' {
                continue;
            }
            if count == k {
                result.push('-');
                count = 0;
            }
            result.push(c);
            count += 1;
        }

        result.chars().rev().collect()
    }
}