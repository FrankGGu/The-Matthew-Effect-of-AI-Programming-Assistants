#include <string.h> // For strlen

static inline int max(int a, int b) {
    return a > b ? a : b;
}

static inline int min(int a, int b) {
    return a < b ? a : b;
}

int longestIdealString(char * s, int k){
    // dp[i] stores the length of the longest ideal subsequence ending with character 'a' + i
    int dp[26] = {0}; 
    int max_overall_len = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        int current_char_val = s[i] - 'a';
        // Initialize current_max_len_ending_here to 1, as the character itself forms a subsequence of length 1.
        int current_max_len_ending_here = 1; 

        // Determine the range of previous characters that can form an ideal pair with current_char_val.
        // The previous character 'prev_char_val' must satisfy |current_char_val - prev_char_val| <= k.
        // This means prev_char_val is in [current_char_val - k, current_char_val + k].
        // We also need to ensure prev_char_val is within 'a' (0) to 'z' (25).
        int start_char_val = max(0, current_char_val - k);
        int end_char_val = min(25, current_char_val + k);

        // Iterate through all possible previous characters in the valid range.
        for (int prev_char_val = start_char_val; prev_char_val <= end_char_val; prev_char_val++) {
            // If there's a valid ideal subsequence ending with 'prev_char_val' (i.e., dp[prev_char_val] > 0),
            // we can potentially extend it with current_char_val.
            // The length would be 1 (for current_char_val) + length of subsequence ending with prev_char_val.
            // We take the maximum such length.
            // Note: if dp[prev_char_val] is 0, 1 + 0 = 1, which means it doesn't extend anything,
            // but it won't incorrectly reduce `current_max_len_ending_here` if it's already greater than 1.
            current_max_len_ending_here = max(current_max_len_ending_here, 1 + dp[prev_char_val]);
        }

        // Update the dp value for the current character.
        dp[current_char_val] = current_max_len_ending_here;

        // Update the overall maximum length found so far.
        max_overall_len = max(max_overall_len, current_max_len_ending_here);
    }

    return max_overall_len;
}