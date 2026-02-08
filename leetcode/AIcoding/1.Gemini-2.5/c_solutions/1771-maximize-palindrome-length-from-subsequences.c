#include <string.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

void reverse_string(char* str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int maximizePalindromeLengthFromSubsequences(char* s1, char* s2) {
    int s1_len = strlen(s1);
    int s2_len = strlen(s2);

    // Precompute LPS for all substrings of s1
    int** s1_lps = NULL;
    if (s1_len > 0) {
        s1_lps = (int**)malloc(s1_len * sizeof(int*));
        for (int i = 0; i < s1_len; i++) {
            s1_lps[i] = (int*)malloc(s1_len * sizeof(int));
            s1_lps[i][i] = 1;
        }

        for (int len = 2; len <= s1_len; len++) {
            for (int i = 0; i <= s1_len - len; i++) {
                int j = i + len - 1;
                if (s1[i] == s1[j]) {
                    s1_lps[i][j] = 2 + (len == 2 ? 0 : s1_lps[i+1][j-1]);
                } else {
                    s1_lps[i][j] = max(s1_lps[i+1][j], s1_lps[i][j-1]);
                }
            }
        }
    }

    // Precompute LPS for all substrings of s2
    int** s2_lps = NULL;
    if (s2_len > 0) {
        s2_lps = (int**)malloc(s2_len * sizeof(int*));
        for (int i = 0; i < s2_len; i++) {
            s2_lps[i] = (int*)malloc(s2_len * sizeof(int));
            s2_lps[i][i] = 1;
        }

        for (int len = 2; len <= s2_len; len++) {
            for (int i = 0; i <= s2_len - len; i++) {
                int j = i + len - 1;
                if (s2[i] == s2[j]) {
                    s2_lps[i][j] = 2 + (len == 2 ? 0 : s2_lps[i+1][j-1]);
                } else {
                    s2_lps[i][j] = max(s2_lps[i+1][j], s2_lps[i][j-1]);
                }
            }
        }
    }

    // Compute s2_rev
    char* s2_copy = (char*)malloc((s2_len + 1) * sizeof(char));
    strcpy(s2_copy, s2);
    reverse_string(s2_copy);

    // Compute LCS of s1 and s2_rev
    int** lcs_dp = (int**)malloc((s1_len + 1) * sizeof(int*));
    for (int i = 0; i <= s1_len; i++) {
        lcs_dp[i] = (int*)malloc((s2_len + 1) * sizeof(int));
    }

    for (int i = 0; i <= s1_len; i++) {
        for (int j = 0; j <= s2_len; j++) {
            if (i == 0 || j == 0) {
                lcs_dp[i][j] = 0;
            } else if (s1[i-1] == s2_copy[j-1]) {
                lcs_dp[i][j] = 1 + lcs_dp[i-1][j-1];
            } else {
                lcs_dp[i][j] = max(lcs_dp[i-1][j], lcs_dp[i][j-1]);
            }
        }
    }

    int max_ans = 0;

    // Case 1: Palindrome entirely from s1 (sub2 is empty)
    if (s1_len > 0) {
        max_ans = max(max_ans, s1_lps[0][s1_len-1]);
    }
    // Case 2: Palindrome entirely from s2 (sub1 is empty)
    if (s2_len > 0) {
        max_ans = max(max_ans, s2_lps[0][s2_len-1]);
    }

    // Case 3: Palindrome formed by X + M_s1 + reverse(X) or X + M_s2 + reverse(X)
    // where X is from s1 and reverse(X) is from s2.
    // i is the length of prefix of s1 used for X
    // j is the length of prefix of s2_rev used for reverse(X)
    for (int i = 0; i <= s1_len; i++) {
        for (int j = 0; j <= s2_len; j++) {
            int current_lcs = lcs_dp[i][j];

            // Palindrome X + reverse(X) (M is empty)
            // This case requires current_lcs > 0 to form a non-empty X and reverse(X)
            // If current_lcs is 0, it means X is empty, which is covered by Case 1 and 2.
            if (current_lcs > 0) {
                max_ans = max(max_ans, 2 * current_lcs);
            }

            // Palindrome X + M_s1 + reverse(X)
            // M_s1 is LPS of remaining s1 part: s1[i...s1_len-1]
            // This requires current_lcs > 0 AND s1_len > i
            if (current_lcs > 0 && i < s1_len) {
                max_ans = max(max_ans, 2 * current_lcs + s1_lps[i][s1_len-1]);
            }

            // Palindrome X + M_s2 + reverse(X)
            // M_s2 is LPS of remaining s2 part: s2[0...s2_len-j-1]
            // This requires current_lcs > 0 AND s2_len - j - 1 >= 0
            if (current_lcs > 0 && (s2_len - j - 1 >= 0)) {
                max_ans = max(max_ans, 2 * current_lcs + s2_lps[0][s2_len-j-1]);
            }
        }
    }

    // Free memory
    if (s1_lps) {
        for (int i = 0; i < s1_len; i++) free(s1_lps[i]);
        free(s1_lps);
    }
    if (s2_lps) {
        for (int i = 0; i < s2_len; i++) free(s2_lps[i]);
        free(s2_lps);
    }
    free(s2_copy);
    for (int i = 0; i <= s1_len; i++) free(lcs_dp[i]);
    free(lcs_dp);

    return max_ans;
}