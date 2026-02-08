use std::collections::HashSet;

const P1: u64 = 31;
const M1: u64 = 1_000_000_007;
const P2: u64 = 37;
const M2: u64 = 1_000_000_009;

struct RollingHasher {
    n: usize,
    h1: Vec<u64>,
    p_pow1: Vec<u64>,
    h2: Vec<u64>,
    p_pow2: Vec<u64>,
}

impl RollingHasher {
    fn new(text: &str) -> Self {
        let n = text.len();
        let text_chars: Vec<u64> = text.chars().map(|c| (c as u64 - 'a' as u64 + 1)).collect();

        let mut h1 = vec![0; n + 1];
        let mut p_pow1 = vec![1; n + 1];
        let mut h2 = vec![0; n + 1];
        let mut p_pow2 = vec![1; n + 1];

        for i in 0..n {
            p_pow1[i + 1] = (p_pow1[i] * P1) % M1;
            h1[i + 1] = (h1[i] * P1 + text_chars[i]) % M1;

            p_pow2[i + 1] = (p_pow2[i] * P2 + text_chars[i]) % M2;
            h2[i + 1] = (h2[i] * P2 + text_chars[i]) % M2;
        }

        RollingHasher {
            n,
            h1,
            p_pow1,
            h2,
            p_pow2,
        }
    }

    fn get_hash(&self, start: usize, end: usize) -> (u64, u64) {
        let len = end - start + 1;

        let hash1 = (self.h1[end + 1] - (self.h1[start] * self.p_pow1[len]) % M1 + M1) % M1;
        let hash2 = (self.h2[end + 1] - (self.h2[start] * self.p_pow2[len]) % M2 + M2) % M2;

        (hash1, hash2)
    }
}

impl Solution {
    pub fn distinct_echo_substrings(text: String) -> i32 {
        let n = text.len();
        if n < 2 {
            return 0;
        }

        let hasher = RollingHasher::new(&text);
        let mut distinct_echo_hashes: HashSet<(u64, u64)> = HashSet::new();

        for i in 0..n {
            for len_half in 1..(n - i) / 2 + 1 {
                let start_first_half = i;
                let end_first_half = i + len_half - 1;
                let start_second_half = i + len_half;
                let end_second_half = i + 2 * len_half - 1;

                let hash_first_half = hasher.get_hash(start_first_half, end_first_half);
                let hash_second_half = hasher.get_hash(start_second_half, end_second_half);

                if hash_first_half == hash_second_half {
                    let full_substring_hash = hasher.get_hash(i, end_second_half);
                    distinct_echo_hashes.insert(full_substring_hash);
                }
            }
        }

        distinct_echo_hashes.len() as i32
    }
}