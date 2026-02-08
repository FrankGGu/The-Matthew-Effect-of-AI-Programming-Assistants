#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool canReach(char * s, int minJump, int maxJump) {
    int n = strlen(s);

    // dp[i] will be true if index i is reachable
    bool* dp = (bool*) calloc(n, sizeof(bool));
    // prefix_sum[i] will store the count of reachable indices from 0 to i
    int* prefix_sum = (int*) calloc(n, sizeof(int));

    dp[0] = true;
    prefix_sum[0] = 1;

    for (int i = 1; i < n; ++i) {
        prefix_sum[i] = prefix_sum[i-1];

        if (s[i] == '0') {
            int L = i - maxJump;
            int R = i - minJump;

            L = (L < 0) ? 0 : L;

            int count_in_window = 0;
            if (R >= L) {
                count_in_window = prefix_sum[R] - (L > 0 ? prefix_sum[L-1] : 0);
            }

            if (count_in_window > 0) {
                dp[i] = true;
                prefix_sum[i]++;
            }
        }
    }

    bool result = dp[n-1];

    free(dp);
    free(prefix_sum);

    return result;
}