impl Solution {
    pub fn license_key_formatting(s: String, k: i32) -> String {
        let s = s.replace("-", "").to_uppercase();
        let mut result = String::new();
        let n = s.len();
        let mut first_group = n % k;

        if first_group == 0 {
            first_group = k;
        }

        result.push_str(&s[0..first_group]);

        for i in first_group..n {
            if (i - first_group) % k == 0 {
                result.push('-');
            }
            result.push(s.chars().nth(i).unwrap());
        }

        result
    }
}