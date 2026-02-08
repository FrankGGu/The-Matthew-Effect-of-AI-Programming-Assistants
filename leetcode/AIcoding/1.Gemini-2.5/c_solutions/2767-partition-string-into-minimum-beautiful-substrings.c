#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

static const long long POWERS_OF_FIVE[] = {1, 5, 25, 125, 625, 3125, 15625};
static const int NUM_POWERS_OF_FIVE = sizeof(POWERS_OF_FIVE) / sizeof(POWERS_OF_FIVE[0]);

bool isPrecomputedPowerOfFive(long long n) {
    for (int i = 0; i < NUM_POWERS_OF_FIVE; i++) {
        if (POWERS_OF_FIVE[i] == n) {
            return true;
        }
    }
    return false;
}

int minimumBeautifulSubstrings(char* s) {
    int n = strlen(s);

    int* dp = (int*)malloc((n + 1) * sizeof(int));
    if (dp == NULL) {
        return -1; 
    }

    for (int i = 0; i <= n; i++) {
        dp[i] = n + 1; 
    }
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            if (s[j] == '0') {
                continue;
            }

            long long val = 0;
            for (int k = j; k < i; k++) {
                val = val * 2 + (s[k] - '0');
            }

            if (isPrecomputedPowerOfFive(val)) {
                if (dp[j] != n + 1) {
                    dp[i] = (dp[i] < dp[j] + 1) ? dp[i] : (dp[j] + 1);
                }
            }
        }
    }

    int result = dp[n];
    free(dp);

    return (result == n + 1) ? -1 : result;
}