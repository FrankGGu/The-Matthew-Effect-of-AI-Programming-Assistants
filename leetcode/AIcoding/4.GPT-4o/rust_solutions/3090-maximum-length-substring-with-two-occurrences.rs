impl Solution {
    pub fn longest_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut left = 0;
        let mut count = std::collections::HashMap::new();

        for right in 0..s.len() {
            *count.entry(s.chars().nth(right).unwrap()).or_insert(0) += 1;

            while count.len() > 2 {
                let left_char = s.chars().nth(left).unwrap();
                *count.get_mut(&left_char).unwrap() -= 1;
                if count[&left_char] == 0 {
                    count.remove(&left_char);
                }
                left += 1;
            }
            max_len = max_len.max(right - left + 1);
        }
        max_len as i32
    }
}