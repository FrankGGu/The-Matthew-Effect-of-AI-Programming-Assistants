use std::collections::HashMap;

impl Solution {
    pub fn count_prefix_suffix_pairs(words: Vec<String>) -> i64 {
        let mut total_pairs: i64 = 0;
        let mut word_hashes_counts: HashMap<u64, i32> = HashMap::new();

        // Using a prime base and modulus for polynomial hashing
        let p: u64 = 31; // A prime greater than the number of possible characters (26 for lowercase English)
        let m: u64 = 1_000_000_007; // A large prime modulus

        for word in words {
            let len = word.len();
            let bytes = word.as_bytes();

            let mut current_prefix_hash: u64 = 0;
            let mut current_suffix_hash: u64 = 0;
            let mut power_p: u64 = 1; // p^k for suffix hash calculation

            for k in 0..len {
                // Character code: 'a' -> 1, 'b' -> 2, ...
                let prefix_char_code = (bytes[k] - b'a' + 1) as u64;
                let suffix_char_code = (bytes[len - 1 - k] - b'a' + 1) as u64;

                // Update prefix hash for substring word[0..k]
                // H(s[0..k]) = (H(s[0..k-1]) * P + s[k]) % M
                current_prefix_hash = (current_prefix_hash * p + prefix_char_code) % m;

                // Update suffix hash for substring word[len-(k+1)..len-1]
                // H(s[len-(k+1)..len-1]) = (s[len-(k+1)] * P^k + H(s[len-k..len-1])) % M
                current_suffix_hash = (current_suffix_hash + suffix_char_code * power_p) % m;

                // If the prefix of length (k+1) matches the suffix of length (k+1)
                if current_prefix_hash == current_suffix_hash {
                    if let Some(&count) = word_hashes_counts.get(&current_prefix_hash) {
                        total_pairs += count as i64;
                    }
                }

                // Update power_p for the next iteration (P^(k+1))
                power_p = (power_p * p) % m;
            }

            // After processing all prefixes/suffixes for the current word,
            // add the hash of the full word to the map.
            // The hash of the full word is `current_prefix_hash` after the loop completes (when k = len-1).
            *word_hashes_counts.entry(current_prefix_hash).or_insert(0) += 1;
        }

        total_pairs
    }
}