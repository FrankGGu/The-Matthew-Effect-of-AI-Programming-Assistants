impl Solution {
    pub fn last_substring(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return String::new();
        }

        let s_bytes = s.as_bytes();

        let mut i = 0; // Start index of the current best suffix
        let mut j = 1; // Start index of the suffix being compared
        let mut k = 0; // Length of common prefix

        while j < n {
            // Compare s[i+k] and s[j+k]
            // Advance k while characters match and are within bounds
            while j + k < n && i + k < n && s_bytes[i + k] == s_bytes[j + k] {
                k += 1;
            }

            if j + k == n {
                // The suffix s[j..] has ended.
                // s[i..] is either longer or equal in length (if i+k==n too).
                // In either case, s[i..] is lexicographically greater or equal.
                // So s[i..] remains the best candidate.
                // Advance j past the common prefix to effectively stop considering s[j..] and its prefixes.
                j = j + k + 1;
            } else if i + k == n {
                // The suffix s[i..] has ended.
                // s[j..] is longer and matches s[i..] up to its end.
                // So s[j..] is lexicographically greater.
                // s[j..] becomes the new best candidate.
                i = j;
                j = i + 1; // Start comparing from the next position after the new i
            } else if s_bytes[i + k] < s_bytes[j + k] {
                // s[j..] is lexicographically greater at the first differing character.
                // s[j..] becomes the new best candidate.
                i = j;
                j = i + 1; // Start comparing from the next position after the new i
            } else { // s_bytes[i + k] > s_bytes[j + k]
                // s[i..] is lexicographically greater at the first differing character.
                // s[i..] remains the best candidate.
                // Advance j past the common prefix and the differing character,
                // because any suffix starting between j and j+k (inclusive) cannot be better than s[i..]
                j = j + k + 1;
            }
            k = 0; // Reset common prefix length for the next comparison
        }

        // The final 'i' holds the starting index of the lexicographically largest suffix.
        // As proven, the lexicographically largest substring must be a suffix.
        s[i..].to_string()
    }
}