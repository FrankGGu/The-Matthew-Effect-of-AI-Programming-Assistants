#include <string.h>
#include <stdlib.h>

long long sumScores(char *s) {
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int *z = (int *)malloc(n * sizeof(int));
    if (z == NULL) {
        return 0; // Should not happen in LeetCode environment for typical constraints
    }

    z[0] = n;
    long long total_score = (long long)n;

    int L = 0, R = 0;
    for (int i = 1; i < n; ++i) {
        if (i <= R) {
            z[i] = (R - i + 1 < z[i - L]) ? (R - i + 1) : z[i - L];
        } else {
            z[i] = 0;
        }

        while (i + z[i] < n && s[z[i]] == s[i + z[i]]) {
            z[i]++;
        }

        if (i + z[i] - 1 > R) {
            L = i;
            R = i + z[i] - 1;
        }
        total_score += z[i];
    }

    free(z);
    return total_score;
}