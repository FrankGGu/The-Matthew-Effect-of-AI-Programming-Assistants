#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScore(char *s) {
    int n = strlen(s);
    int max_score = 0;
    int left_ones = 0;

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == '1') {
            left_ones++;
        }
        int right_zeros = (n - i - 1) - (left_ones);
        int score = left_ones + right_zeros;
        if (score > max_score) {
            max_score = score;
        }
    }

    return max_score;
}