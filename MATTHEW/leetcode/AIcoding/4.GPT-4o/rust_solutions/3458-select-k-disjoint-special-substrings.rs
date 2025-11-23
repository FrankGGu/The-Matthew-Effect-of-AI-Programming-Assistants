impl Solution {
    pub fn count_special_substrings(s: String, k: i32) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut count = 0;

        for i in 0..n {
            let mut freq = std::collections::HashMap::new();
            let mut unique_count = 0;

            for j in i..n {
                let c = chars[j];
                let entry = freq.entry(c).or_insert(0);
                *entry += 1;
                if *entry == 1 {
                    unique_count += 1;
                }
                if unique_count == k {
                    count += 1;
                } else if unique_count > k {
                    break;
                }
            }
        }
        count
    }
}