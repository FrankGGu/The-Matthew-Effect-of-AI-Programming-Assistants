impl Solution {
    pub fn is_match(s: String, p: String) -> bool {
        let s_chars: Vec<char> = s.chars().collect();
        let p_chars: Vec<char> = p.chars().collect();

        let m = s_chars.len();
        let n = p_chars.len();

        // dp[i][j] will be true if the first i characters of s match the first j characters of p.
        // We use two rows for space optimization: prev_row for dp[i-1] and curr_row for dp[i].
        let mut prev_row = vec![false; n + 1];
        let mut curr_row = vec![false; n + 1];

        // Base case: empty string matches empty pattern
        prev_row[0] = true;

        // Initialize prev_row for s="" matching p.
        // Only '*' can match an empty string. If p[j-1] is '*', it can match an empty sequence
        // if the pattern up to p[j-2] also matched an empty sequence.
        for j in 1..=n {
            if p_chars[j - 1] == '*' {
                prev_row[j] = prev_row[j - 1];
            }
            // If p_chars[j-1] is not '*', prev_row[j] remains false, which is correct
            // because a non-empty pattern without '*' cannot match an empty string.
        }

        // Fill the DP table row by row
        for i in 1..=m {
            // curr_row[0] is false because a non-empty string s_chars[0..i-1] cannot match an empty pattern.
            curr_row[0] = false; 
            for j in 1..=n {
                if p_chars[j - 1] == s_chars[i - 1] || p_chars[j - 1] == '?' {
                    // Current characters match or '?' matches s_chars[i-1].
                    // Result depends on matching the previous parts of s and p.
                    curr_row[j] = prev_row[j - 1];
                } else if p_chars[j - 1] == '*' {
                    // '*' can match an empty sequence (curr_row[j-1])
                    // OR '*' can match the current character s_chars[i-1] (prev_row[j])
                    // and potentially more characters from s.
                    curr_row[j] = curr_row[j - 1] || prev_row[j];
                } else {
                    // Characters do not match and p_chars[j-1] is not a wildcard.
                    curr_row[j] = false;
                }
            }
            // The current row becomes the previous row for the next iteration.
            prev_row.copy_from_slice(&curr_row);
        }

        // The final result is whether the entire string s matches the entire pattern p.
        prev_row[n]
    }
}