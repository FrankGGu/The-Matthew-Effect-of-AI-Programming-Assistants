#include <stdbool.h>
#include <string.h>

int memo[30][30][31];

bool solve(char* s1, char* s2, int i1, int i2, int len) {
    if (memo[i1][i2][len] != -1) {
        return memo[i1][i2][len];
    }

    if (len == 1) {
        return memo[i1][i2][len] = (s1[i1] == s2[i2]);
    }

    int counts[26] = {0};
    for (int i = 0; i < len; i++) {
        counts[s1[i1 + i] - 'a']++;
        counts[s2[i2 + i] - 'a']--;
    }
    for (int i = 0; i < 26; i++) {
        if (counts[i] != 0) {
            return memo[i1][i2][len] = false;
        }
    }

    bool res = false;
    for (int k = 1; k < len; k++) {
        // Case 1: No swap
        if (solve(s1, s2, i1, i2, k) && solve(s1, s2, i1 + k, i2 + k, len - k)) {
            res = true;
            break;
        }

        // Case 2: Swap
        if (solve(s1, s2, i1, i2 + len - k, k) && solve(s1, s2, i1 + k, i2, len - k)) {
            res = true;
            break;
        }
    }

    return memo[i1][i2][len] = res;
}

bool isScramble(char* s1, char* s2) {
    int n = strlen(s1);
    int m = strlen(s2);

    if (n != m) {
        return false;
    }
    if (n == 0) {
        return true;
    }
    if (strcmp(s1, s2) == 0) {
        return true;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            for (int l = 0; l <= n; l++) {
                memo[i][j][l] = -1;
            }
        }
    }

    return solve(s1, s2, 0, 0, n);
}