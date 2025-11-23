impl Solution {
    pub fn longest_decomposition(text: String) -> i32 {
        let n = text.len();
        if n == 0 {
            return 0;
        }

        // Using two different bases and moduli for polynomial hashing
        // to reduce collision probability.
        const BASE1: u64 = 31; // A prime number
        const MOD1: u64 = 1_000_000_007; // A large prime number

        const BASE2: u64 = 37; // Another prime number
        const MOD2: u60 = 1_000_000_009; // Another large prime number

        // Precompute prefix hashes and powers of bases
        // prefix_hashes[i] stores hash of text[0..i-1]
        let mut prefix_hashes1 = vec![0; n + 1];
        let mut prefix_hashes2 = vec![0; n + 1];
        // powers[i] stores BASE^i % MOD
        let mut powers1 = vec![1; n + 1];
        let mut powers2 = vec![1; n + 1];

        for i in 0..n {
            let char_val = (text.as_bytes()[i] - b'a' + 1) as u64; // Map 'a' to 1, 'b' to 2, etc.

            prefix_hashes1[i + 1] = (prefix_hashes1[i] * BASE1 + char_val) % MOD1;
            prefix_hashes2[i + 1] = (prefix_hashes2[i] * BASE2 + char_val) % MOD2;

            powers1[i + 1] = (powers1[i] * BASE1) % MOD1;
            powers2[i + 1] = (powers2[i] * BASE2) % MOD2;
        }

        // Helper function to get hash of substring s[start..end] (inclusive)
        // This function uses the precomputed prefix hashes and powers.
        let get_hash = |start: usize, end: usize| -> (u64, u64) {
            if start > end {
                return (0, 0); // Hash for an empty string
            }
            let len = (end - start + 1) as usize;

            let mut h1 = prefix_hashes1[end + 1];
            let h_prev1 = prefix_hashes1[start];
            h1 = (h1 + MOD1 - (h_prev1 * powers1[len]) % MOD1) % MOD1;

            let mut h2 = prefix_hashes2[end + 1];
            let h_prev2 = prefix_hashes2[start];
            h2 = (h2 + MOD2 - (h_prev2 * powers2[len]) % MOD2) % MOD2;

            (h1, h2)
        };

        let mut ans = 0;
        let mut left = 0;
        let mut right = n - 1;

        while left <= right {
            if left == right {
                // If only one character remains, it forms one chunk.
                ans += 1;
                break;
            }

            let mut found_match = false;
            // Iterate `len` from 1 up to half the remaining length.
            // We search for the shortest possible matching prefix and suffix
            // to maximize the remaining middle part for further decomposition.
            for len in 1..=((right - left + 1) / 2) {
                // Get hash of prefix text[left .. left + len - 1]
                let prefix_hash = get_hash(left, left + len - 1);
                // Get hash of suffix text[right - len + 1 .. right]
                let suffix_hash = get_hash(right - len + 1, right);

                if prefix_hash == suffix_hash {
                    ans += 2; // Found a pair of matching chunks
                    left += len; // Move left pointer past the prefix
                    right -= len; // Move right pointer before the suffix
                    found_match = true;
                    break; // Break and continue with the new `left` and `right` bounds
                }
            }

            if !found_match {
                // If no matching prefix/suffix pair is found for the current segment,
                // the entire remaining segment forms one chunk.
                ans += 1;
                break;
            }
        }

        ans
    }
}