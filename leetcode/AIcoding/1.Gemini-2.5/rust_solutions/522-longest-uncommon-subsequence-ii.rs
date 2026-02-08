impl Solution {
    pub fn find_lu_s_length(strs: Vec<String>) -> i32 {
        let n = strs.len();

        // Create a mutable copy and sort strings by length in descending order.
        // If lengths are equal, the relative order doesn't matter for correctness,
        // but a consistent sort (e.g., lexicographical for tie-breaking) is good practice.
        let mut sorted_strs = strs;
        sorted_strs.sort_by(|a, b| b.len().cmp(&a.len()));

        for i in 0..n {
            let s_i = &sorted_strs[i];
            let mut is_lus_candidate = true;

            // Check if s_i is a subsequence of any other string s_j
            for j in 0..n {
                // Skip checking against itself
                if i == j {
                    continue;
                }
                let s_j = &sorted_strs[j];

                // If s_i is a subsequence of any other s_j, it cannot be an LUS
                if Self::is_subsequence(s_i, s_j) {
                    is_lus_candidate = false;
                    break; // No need to check further for this s_i
                }
            }

            // If s_i is not a subsequence of any other string, it's an LUS.
            // Since we iterate from longest to shortest, the first one found is the longest.
            if is_lus_candidate {
                return s_i.len() as i32;
            }
        }

        // If no such string is found, return -1
        -1
    }

    // Helper function to check if s1 is a subsequence of s2
    fn is_subsequence(s1: &str, s2: &str) -> bool {
        let mut i = 0; // Pointer for s1
        let mut j = 0; // Pointer for s2

        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();

        while i < s1_bytes.len() && j < s2_bytes.len() {
            if s1_bytes[i] == s2_bytes[j] {
                i += 1;
            }
            j += 1;
        }
        // If i reached the end of s1, then s1 is a subsequence of s2
        i == s1_bytes.len()
    }
}