use std::cmp::min;

impl Solution {
    pub fn min_characters(a: String, b: String) -> i32 {
        let n = a.len() as i32;
        let m = b.len() as i32;

        let mut freq_a = [0; 26];
        for &c in a.as_bytes() {
            freq_a[(c - b'a') as usize] += 1;
        }

        let mut freq_b = [0; 26];
        for &c in b.as_bytes() {
            freq_b[(c - b'a') as usize] += 1;
        }

        let mut prefix_freq_a = [0; 26];
        prefix_freq_a[0] = freq_a[0];
        for i in 1..26 {
            prefix_freq_a[i] = prefix_freq_a[i - 1] + freq_a[i];
        }

        let mut prefix_freq_b = [0; 26];
        prefix_freq_b[0] = freq_b[0];
        for i in 1..26 {
            prefix_freq_b[i] = prefix_freq_b[i - 1] + freq_b[i];
        }

        let mut ans = n + m;

        // Condition 1: Every character in 'a' is strictly less than every character in 'b'.
        // This means there exists a character 'c' (from 'a' to 'y') such that:
        // all characters in 'a' are <= c
        // all characters in 'b' are > c
        for char_idx_c in 0..25 { // Iterate 'c' from 'a' (idx 0) to 'y' (idx 24)
            // Cost for 'a': characters in 'a' that are > c must be changed.
            // These are total_a - (chars in 'a' <= c)
            let cost_a = n - prefix_freq_a[char_idx_c];
            // Cost for 'b': characters in 'b' that are <= c must be changed.
            let cost_b = prefix_freq_b[char_idx_c];
            ans = min(ans, cost_a + cost_b);
        }

        // Condition 2: Every character in 'b' is strictly less than every character in 'a'.
        // Symmetric to condition 1.
        for char_idx_c in 0..25 { // Iterate 'c' from 'a' (idx 0) to 'y' (idx 24)
            // Cost for 'b': characters in 'b' that are > c must be changed.
            let cost_b = m - prefix_freq_b[char_idx_c];
            // Cost for 'a': characters in 'a' that are <= c must be changed.
            let cost_a = prefix_freq_a[char_idx_c];
            ans = min(ans, cost_a + cost_b);
        }

        // Condition 3: Every character in 'a' and every character in 'b' are the same character.
        // This means all characters in 'a' become 'k' and all characters in 'b' become 'k'.
        // 'k' can be any character from 'a' (idx 0) to 'z' (idx 25).
        for char_idx_k in 0..26 {
            // Cost for 'a': characters in 'a' that are not 'k' must be changed.
            let cost_a = n - freq_a[char_idx_k];
            // Cost for 'b': characters in 'b' that are not 'k' must be changed.
            let cost_b = m - freq_b[char_idx_k];
            ans = min(ans, cost_a + cost_b);
        }

        ans
    }
}