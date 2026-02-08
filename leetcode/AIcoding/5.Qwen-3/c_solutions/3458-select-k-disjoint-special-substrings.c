#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int score;
} Substring;

int compare(const void *a, const void *b) {
    return ((Substring *)b)->score - ((Substring *)a)->score;
}

int maxScore(int k, char *s) {
    int n = strlen(s);
    int *prefix = (int *)malloc(n * sizeof(int));
    int *suffix = (int *)malloc(n * sizeof(int));
    int *dp = (int *)malloc(n * sizeof(int));
    int *prev = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        prefix[i] = 1;
        for (int j = 0; j < i; j++) {
            if (s[j] == s[i]) {
                prefix[i] = (prefix[j] + 1) > prefix[i] ? (prefix[j] + 1) : prefix[i];
            }
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        suffix[i] = 1;
        for (int j = n - 1; j > i; j--) {
            if (s[j] == s[i]) {
                suffix[i] = (suffix[j] + 1) > suffix[i] ? (suffix[j] + 1) : suffix[i];
            }
        }
    }

    for (int i = 0; i < n; i++) {
        dp[i] = prefix[i];
        prev[i] = -1;
        for (int j = 0; j < i; j++) {
            if (s[j] == s[i]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }
    }

    Substring *substrings = (Substring *)malloc(n * sizeof(Substring));
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] > 1) {
            substrings[count].start = i - dp[i] + 1;
            substrings[count].end = i;
            substrings[count].score = dp[i];
            count++;
        }
    }

    qsort(substrings, count, sizeof(Substring), compare);

    int result = 0;
    int used[1000] = {0};

    for (int i = 0; i < count && k > 0; i++) {
        int start = substrings[i].start;
        int end = substrings[i].end;
        int overlap = 0;
        for (int j = start; j <= end; j++) {
            if (used[j]) {
                overlap = 1;
                break;
            }
        }
        if (!overlap) {
            for (int j = start; j <= end; j++) {
                used[j] = 1;
            }
            result += substrings[i].score;
            k--;
        }
    }

    free(prefix);
    free(suffix);
    free(dp);
    free(prev);
    free(substrings);
    return result;
}