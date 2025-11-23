impl Solution {
    pub fn thousand_separator(n: i32) -> String {
        let mut s = n.to_string();
        let mut result = String::new();
        let mut count = 0;
        for i in (0..s.len()).rev() {
            result.push(s.chars().nth(i).unwrap());
            count += 1;
            if count == 3 && i != 0 {
                result.push('.');
                count = 0;
            }
        }
        result.chars().rev().collect()
    }
}