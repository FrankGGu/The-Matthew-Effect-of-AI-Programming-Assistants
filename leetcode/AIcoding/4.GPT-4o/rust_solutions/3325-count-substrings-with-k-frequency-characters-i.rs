impl Solution {
    pub fn count_k_substrings(s: String, k: i32) -> i32 {
        let mut count = 0;
        let mut left = 0;
        let mut freq = std::collections::HashMap::new();

        for right in 0..s.len() {
            *freq.entry(s.chars().nth(right).unwrap()).or_insert(0) += 1;

            while freq.len() > k as usize {
                let left_char = s.chars().nth(left).unwrap();
                *freq.get_mut(&left_char).unwrap() -= 1;
                if freq[&left_char] == 0 {
                    freq.remove(&left_char);
                }
                left += 1;
            }

            if freq.len() == k as usize {
                count += 1;
            }
        }

        count
    }
}