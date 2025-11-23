impl Solution {
    pub fn kth_distinct(strings: Vec<String>, k: i32) -> String {
        let mut count = 0;
        let mut freq = std::collections::HashMap::new();

        for s in &strings {
            *freq.entry(s).or_insert(0) += 1;
        }

        for s in strings {
            if freq[&s] == 1 {
                count += 1;
                if count == k {
                    return s;
                }
            }
        }

        String::new()
    }
}