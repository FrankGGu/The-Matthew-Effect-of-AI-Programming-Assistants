#include <stdlib.h>
#include <string.h>
#include <stdio.h> // For potential debugging, though not used in final solution

char* findTheOriginalString(char* s, char* t) {
    int n = strlen(s);
    int m = strlen(t);

    // path[i][j] stores the decision made at (i, j)
    // 'S': take s[i], move to (i+1, j)
    // 'T': take t[j], move to (i, j+1)
    // 'B': take s[i] (which equals t[j]), move to (i+1, j+1)
    // 'E': end of string (base case for dp[N][M])
    char** path = (char**)malloc((n + 1) * sizeof(char*));
    for (int i = 0; i <= n; i++) {
        path[i] = (char*)malloc((m + 1) * sizeof(char));
    }

    // Fill base cases for path table
    // If s is exhausted (cur_s == n), take remaining characters from t
    for (int j = 0; j < m; j++) {
        path[n][j] = 'T';
    }
    // If t is exhausted (cur_t == m), take remaining characters from s
    for (int i = 0; i < n; i++) {
        path[i][m] = 'S';
    }
    // Both s and t are exhausted
    path[n][m] = 'E'; // Sentinel for end

    // Fill DP table from bottom-right to top-left
    for (int i = n - 1; i >= 0; i--) {
        for (int j = m - 1; j >= 0; j--) {
            if (s[i] == t[j]) {
                // If characters are equal, they must be part of the same character in the original string
                path[i][j] = 'B';
            } else {
                // If characters are different, choose the one that is lexicographically smaller
                // This choice determines the first character of the resulting string,
                // and since they are different, this local choice is sufficient.
                if (s[i] < t[j]) {
                    path[i][j] = 'S';
                } else { // s[i] > t[j]
                    path[i][j] = 'T';
                }
            }
        }
    }

    // Reconstruct the string by traversing the path table from (0, 0)
    // The maximum possible length of the result string is n + m
    char* result = (char*)malloc((n + m + 1) * sizeof(char));
    int res_idx = 0;
    int cur_s = 0;
    int cur_t = 0;

    while (cur_s < n || cur_t < m) {
        if (cur_s < n && cur_t < m) {
            char decision = path[cur_s][cur_t];
            if (decision == 'B') {
                result[res_idx++] = s[cur_s];
                cur_s++;
                cur_t++;
            } else if (decision == 'S') {
                result[res_idx++] = s[cur_s];
                cur_s++;
            } else { // decision == 'T'
                result[res_idx++] = t[cur_t];
                cur_t++;
            }
        } else if (cur_s < n) { // t is exhausted, append remaining s characters
            result[res_idx++] = s[cur_s];
            cur_s++;
        } else { // s is exhausted, append remaining t characters
            result[res_idx++] = t[cur_t];
            cur_t++;
        }
    }
    result[res_idx] = '\0'; // Null-terminate the result string

    // Free allocated path memory
    for (int i = 0; i <= n; i++) {
        free(path[i]);
    }
    free(path);

    return result;
}