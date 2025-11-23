impl Solution {
    pub fn nearest_palindrome(n: String) -> String {
        let num: i64 = n.parse().unwrap();
        let len = n.len();

        let mut candidates: Vec<i64> = Vec::new();

        // Candidate 1: 10^(len-1) - 1 (e.g., 9, 99, 999)
        // For len=1, this is 10^0 - 1 = 0.
        candidates.push(10i64.pow((len - 1) as u32) - 1);

        // Candidate 2: 10^(len) + 1 (e.g., 11, 101, 1001)
        candidates.push(10i64.pow(len as u32) + 1);

        // Candidates generated from the prefix of n
        let prefix_len = (len + 1) / 2;
        let prefix_str = &n[0..prefix_len];
        let prefix_val = prefix_str.parse::<i64>().unwrap();

        let is_odd_len = len % 2 != 0;

        for i in -1..=1 { // Consider prefix_val - 1, prefix_val, prefix_val + 1
            let current_prefix_val = prefix_val + i;
            if current_prefix_val < 0 { // Skip strictly negative prefixes
                continue;
            }
            let current_prefix_str = current_prefix_val.to_string();
            candidates.push(Self::create_palindrome(&current_prefix_str, is_odd_len));
        }

        // Filter out the number itself and find the closest palindrome
        let mut min_diff = i64::MAX;
        let mut result = -1i64; // Initialize with a value that will be overwritten

        for &p in candidates.iter() {
            if p == num {
                continue;
            }
            let diff = (p - num).abs();
            if diff < min_diff {
                min_diff = diff;
                result = p;
            } else if diff == min_diff {
                result = result.min(p); // Choose smaller palindrome if differences are equal
            }
        }

        result.to_string()
    }

    fn create_palindrome(prefix_str: &str, is_odd_len: bool) -> i64 {
        let mut s = prefix_str.to_string();
        let mut suffix = prefix_str.to_string();
        if is_odd_len {
            suffix.pop(); // Remove the last char (middle digit) for odd length palindromes
        }
        s.push_str(&suffix.chars().rev().collect::<String>()); // Append reversed suffix
        s.parse::<i64>().unwrap()
    }
}