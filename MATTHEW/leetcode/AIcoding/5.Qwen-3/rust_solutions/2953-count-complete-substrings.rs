struct Solution;

impl Solution {
    pub fn count_complete_substrings(s: String) -> i32 {
        let mut result = 0;
        let s = s.as_bytes();
        let mut left = 0;
        let n = s.len();

        while left < n {
            let mut right = left + 1;
            let mut freq = std::collections::HashMap::new();
            freq.insert(s[left], 1);

            while right < n {
                if (s[right] as char).abs_diff(s[right - 1] as char) > 1 {
                    break;
                }
                *freq.entry(s[right]).or_insert(0) += 1;
                right += 1;
            }

            let mut unique_chars = 0;
            let mut freq_count = std::collections::HashMap::new();
            let mut current = left;

            while current < right {
                let c = s[current];
                let count = *freq_count.get(&c).unwrap_or(&0);
                if count == 0 {
                    unique_chars += 1;
                }
                *freq_count.entry(c).or_insert(0) += 1;

                let mut valid = true;
                for &v in freq_count.values() {
                    if v != 1 {
                        valid = false;
                        break;
                    }
                }

                if valid {
                    result += 1;
                }

                current += 1;
            }

            left = right;
        }

        result
    }
}