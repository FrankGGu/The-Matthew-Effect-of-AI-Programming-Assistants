#include <stdio.h>
#include <stdlib.h>

int longestWPI(char* s) {
    int n = 0;
    while (s[n]) n++;

    int score[n];
    for (int i = 0; i < n; i++) {
        score[i] = (s[i] == 'T') ? 1 : -1;
    }

    int max_len = 0;
    int first_occurrence[2 * n + 2];
    for (int i = 0; i < 2 * n + 2; i++) {
        first_occurrence[i] = -1;
    }

    int total_score = 0;
    for (int i = 0; i < n; i++) {
        total_score += score[i];
        if (total_score == 1 && i + 1 > max_len) {
            max_len = i + 1;
        }
        if (first_occurrence[total_score + n] == -1) {
            first_occurrence[total_score + n] = i;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        total_score -= score[i];
        if (first_occurrence[total_score + n] != -1) {
            int len = i - first_occurrence[total_score + n];
            if (len > max_len) {
                max_len = len;
            }
        }
    }

    return max_len;
}