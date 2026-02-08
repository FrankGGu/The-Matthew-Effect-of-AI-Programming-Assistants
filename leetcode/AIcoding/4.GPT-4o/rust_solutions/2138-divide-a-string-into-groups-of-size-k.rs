impl Solution {
    pub fn divide_string(s: String, k: usize, fill: char) -> Vec<String> {
        let mut result = Vec::new();
        let mut current = String::new();

        for (i, c) in s.chars().enumerate() {
            current.push(c);
            if current.len() == k {
                result.push(current);
                current = String::new();
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