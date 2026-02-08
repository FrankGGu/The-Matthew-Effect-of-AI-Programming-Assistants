impl Solution {
    pub fn divide_string(s: String, k: i32, fill: char) -> Vec<String> {
        let k = k as usize;
        let mut result = Vec::new();
        let mut current = String::new();
        for c in s.chars() {
            current.push(c);
            if current.len() == k {
                result.push(current.clone());
                current.clear();
            }
        }
        if !current.is_empty() {
            while current.len() < k {
                current.push(fill);
            }
            result.push(current);
        }
        result
    }
}