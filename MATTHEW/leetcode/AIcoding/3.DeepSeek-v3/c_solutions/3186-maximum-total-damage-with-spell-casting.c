#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(long long*)a - *(long long*)b;
}

long long maximumTotalDamage(int* power, int powerSize) {
    long long *sorted = (long long*)malloc(powerSize * sizeof(long long));
    for (int i = 0; i < powerSize; i++) {
        sorted[i] = power[i];
    }
    qsort(sorted, powerSize, sizeof(long long), cmp);

    long long *unique = (long long*)malloc(powerSize * sizeof(long long));
    long long *freq = (long long*)malloc(powerSize * sizeof(long long));
    int n = 0;

    for (int i = 0; i < powerSize; i++) {
        if (i == 0 || sorted[i] != sorted[i-1]) {
            unique[n] = sorted[i];
            freq[n] = 1;
            n++;
        } else {
            freq[n-1]++;
        }
    }

    long long *dp = (long long*)malloc(n * sizeof(long long));
    int prev = -1;

    for (int i = 0; i < n; i++) {
        long long current = unique[i] * freq[i];

        while (prev + 1 < i && unique[prev + 1] <= unique[i] - 3) {
            prev++;
        }

        long long take = current;
        if (prev >= 0) {
            take += dp[prev];
        }

        long long not_take = (i > 0) ? dp[i-1] : 0;
        dp[i] = (take > not_take) ? take : not_take;
    }

    long long result = dp[n-1];
    free(sorted);
    free(unique);
    free(freq);
    free(dp);
    return result;
}