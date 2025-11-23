struct Solution;

impl Solution {
    pub fn hash_divided_string(s: String, k: i32) -> bool {
        let n = s.len();
        let k = k as usize;

        if k == 0 {
            return false;
        }
        if n % k != 0 {
            return false;
        }
        if k == 1 {
            return true;
        }

        let segment_len = n / k;
        if segment_len == 0 {
            return false;
        }

        let s_bytes = s.as_bytes();

        let p: u64 = 31;
        let m: u64 = 1_000_000_007;

        let mut powers = vec![1; n + 1];
        for i in 1..=n {
            powers[i] = (powers[i - 1] * p) % m;
        }

        let mut prefix_hashes = vec![0; n + 1];
        for i in 0..n {
            prefix_hashes[i + 1] = (prefix_hashes[i] * p + (s_bytes[i] - b'a' + 1) as u64) % m;
        }

        let get_hash = |start: usize, end: usize| {
            let len = end - start + 1;
            let mut h = (prefix_hashes[end + 1] - (prefix_hashes[start] * powers[len]) % m + m) % m;
            h
        };

        let target_hash = get_hash(0, segment_len - 1);

        for i in 1..k {
            let current_start = i * segment_len;
            let current_end = (i + 1) * segment_len - 1;
            if get_hash(current_start, current_end) != target_hash {
                return false;
            }
        }

        true
    }
}