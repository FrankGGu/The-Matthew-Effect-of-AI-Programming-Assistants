impl Solution {
    pub fn thousand_separator(n: i32) -> String {
        let s = n.to_string();
        let mut result = String::new();
        let len = s.len();
        let mut count = 0;

        for (i, c) in s.chars().rev().enumerate() {
            if count > 0 && count % 3 == 0 {
                result.push('.');
            }
            result.push(c);
            count += 1;
        }

        result.chars().rev().collect()
    }
}