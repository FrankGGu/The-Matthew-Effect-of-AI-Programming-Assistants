impl Solution {
    pub fn palindrome_rearrangement_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = s.len();
        let s_bytes = s.as_bytes();

        // prefix_mask[i] stores the XOR sum of character parities for s[0...i-1]
        // Each bit in the mask corresponds to a character 'a' through 'z'.
        // If the k-th bit is set, it means the k-th character ('a' + k) appears an odd number of times in s[0...i-1].
        // prefix_mask[0] is 0 (empty string has no characters, all counts are even).
        // prefix_mask[i+1] is prefix_mask[i] XOR (1 << (s[i] - b'a')).
        let mut prefix_mask = vec![0u32; n + 1];
        for i in 0..n {
            prefix_mask[i + 1] = prefix_mask[i] ^ (1 << (s_bytes[i] - b'a'));
        }

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let a = query[0] as usize;
            let b = query[1] as usize;
            let c = query[2] as usize;
            let d = query[3] as usize;

            // Calculate the parity mask for the substring s[a..b] (inclusive)
            // This is prefix_mask[b+1] XOR prefix_mask[a].
            // If the k-th bit is set in mask1, it means char 'a'+k appears an odd number of times in s[a..b].
            let mask1 = prefix_mask[b + 1] ^ prefix_mask[a];

            // Calculate the parity mask for the substring s[c..d] (inclusive)
            let mask2 = prefix_mask[d + 1] ^ prefix_mask[c];

            // A string can be rearranged into a palindrome if and only if at most one character appears an odd number of times.
            // This means the popcount (number of set bits) of its parity mask must be 0 or 1.

            // Condition 1: Substring s[a..b] can be rearranged into a palindrome.
            let cond1 = mask1.count_ones() <= 1;

            // Condition 2: Substring s[c..d] can be rearranged into a palindrome.
            let cond2 = mask2.count_ones() <= 1;

            // Condition 3: The combined string (s[a..b] + s[c..d]) can be rearranged into a palindrome.
            // The parity mask for the combined string is mask1 XOR mask2.
            // This is because (odd + odd) = even, (odd + even) = odd, (even + even) = even,
            // which corresponds to XOR operation on parities.
            let cond3 = (mask1 ^ mask2).count_ones() <= 1;

            // All three conditions must be true for the query to return true.
            results.push(cond1 && cond2 && cond3);
        }

        results
    }
}