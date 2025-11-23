impl Solution {
    pub fn custom_sort_string(order: String, s: String) -> String {
        let mut count = std::collections::HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut result = String::new();
        for c in order.chars() {
            if let Some(&num) = count.get(&c) {
                result.push_str(&c.to_string().repeat(num));
                count.remove(&c);
            }
        }

        for (&c, &num) in &count {
            result.push_str(&c.to_string().repeat(num));
        }

        result
    }
}