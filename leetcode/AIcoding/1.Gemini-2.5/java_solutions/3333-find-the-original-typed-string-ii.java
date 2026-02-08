import java.util.Arrays;

class Solution {
    private String s;
    private String t;
    private int N; // s.length()
    private int M; // t.length()

    // nextTOccurrence[t_idx][char_code] stores the smallest index k >= t_idx such that t[k] == char_code.
    // char_code 0-25 for 'a'-'z'.
    private int[][] nextTOccurrence;

    // memo[s_match_idx][t_consume_idx][last_char_in_orig_prefix_code] stores the lexicographically smallest suffix of orig.
    // last_char_in_orig_prefix_code: 0 for dummy (empty orig_prefix), 1-26 for 'a'-'z'.
    private String[][][] memo;

    public String findTheOriginalString(String s, String t) {
        this.s = s;
        this.t = t;
        this.N = s.length();
        this.M = t.length();

        // Precompute next_t_occurrence
        nextTOccurrence = new int[M + 1][26];
        for (int charCode = 0; charCode < 26; charCode++) {
            nextTOccurrence[M][charCode] = -1; // No more chars in t from index M
        }
        for (int j = M - 1; j >= 0; j--) {
            for (int charCode = 0; charCode < 26; charCode++) {
                nextTOccurrence[j][charCode] = nextTOccurrence[j + 1][charCode];
            }
            nextTOccurrence[j][t.charAt(j) - 'a'] = j;
        }

        memo = new String[N + 1][M + 1][27]; // 27 for 0 (dummy) and 1-26 ('a'-'z')

        // Java arrays are initialized with null for String, so explicit fill not strictly needed for null.

        return solve(0, 0, 0); // Start with 0 s_match_idx, 0 t_consume_idx, 0 (dummy) last_char_in_orig_prefix_code
    }

    // solve(s_match_idx, t_consume_idx, last_char_in_orig_prefix_code) returns the lexicographically smallest suffix of orig
    // that, when appended to an orig_prefix, results in s[s_match_idx...] being matched,
    // using t[t_consume_idx...] and where the last character of orig_prefix was last_char_in_orig_prefix_code.
    private String solve(int s_match_idx, int t_consume_idx, int last_char_in_orig_prefix_code) {
        // Base case 1: All of 's' has been matched. Return empty string.
        if (s_match_idx == N) {
            return "";
        }
        // Base case 2: All of 't' has been consumed, but 's' is not fully matched. No solution from here.
        if (t_consume_idx == M) {
            return null;
        }

        // Check memoization table
        if (memo[s_match_idx][t_consume_idx][last_char_in_orig_prefix_code] != null) {
            return memo[s_match_idx][t_consume_idx][last_char_in_orig_prefix_code];
        }

        String bestSuffix = null;

        // Try each character 'a' through 'z' as the next character to append to 'orig_prefix'.
        for (int char_code_to_append = 0; char_code_to_append < 26; char_code_to_append++) {
            char charToAppend = (char) ('a' + char_code_to_append);

            // Find the first occurrence of charToAppend in t at or after t_consume_idx.
            int next_t_idx = nextTOccurrence[t_consume_idx][char_code_to_append];
            if (next_t_idx == -1) {
                continue; // Character not found in remaining 't'.
            }

            int next_s_match_idx = s_match_idx;
            boolean isValidTransition = false;

            if (last_char_in_orig_prefix_code == 0) { // orig_prefix was empty
                // This is the first character of 'orig'. It must match s[0].
                // This state should only be reached with s_match_idx == 0.
                if (s_match_idx == 0 && charToAppend == s.charAt(0)) {
                    next_s_match_idx = 1;
                    isValidTransition = true;
                }
                // If s_match_idx > 0 and last_char_in_orig_prefix_code == 0, it's an invalid state,
                // as an empty orig_prefix can only lead to s_match_idx == 0.
                // In such a case, isValidTransition remains false, and we won't recurse.
            } else { // orig_prefix was not empty
                char lastCharInOrigPrefix = (char) ('a' + last_char_in_orig_prefix_code - 1);
                if (charToAppend == lastCharInOrigPrefix) {
                    // If charToAppend is same as last char in orig_prefix, the deduplicated string (s) does not change.
                    // So s_match_idx remains the same.
                    next_s_match_idx = s_match_idx;
                    isValidTransition = true;
                } else { // charToAppend != lastCharInOrigPrefix
                    // If charToAppend is different, it gets appended to the deduplicated string.
                    // So s[s_match_idx] must be charToAppend.
                    if (s_match_idx < N && charToAppend == s.charAt(s_match_idx)) {
                        next_s_match_idx = s_match_idx + 1;
                        isValidTransition = true;
                    } else {
                        // This charToAppend would make 's' not match. Invalid.
                    }
                }
            }

            if (isValidTransition) {
                String res = solve(next_s_match_idx, next_t_idx + 1, char_code_to_append + 1); // c_code + 1 is the new last_char_in_orig_prefix_code
                if (res != null) {
                    String candidateOrig = charToAppend + res;
                    if (bestSuffix == null || candidateOrig.compareTo(bestSuffix) < 0) {
                        bestSuffix = candidateOrig;
                    }
                }
            }
        }

        // Store and return the best suffix found for this state.
        memo[s_match_idx][t_consume_idx][last_char_in_orig_prefix_code] = bestSuffix;
        return bestSuffix;
    }
}