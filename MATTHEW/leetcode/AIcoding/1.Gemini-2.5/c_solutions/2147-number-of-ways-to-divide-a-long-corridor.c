#include <string.h>
#include <stdlib.h>

long long numberOfWays(char* corridor) {
    long long MOD = 1000000007;
    int len = strlen(corridor);

    int* s_indices = (int*)malloc(sizeof(int) * len);
    int s_count = 0;

    for (int i = 0; i < len; i++) {
        if (corridor[i] == 'S') {
            s_indices[s_count++] = i;
        }
    }

    if (s_count == 0 || s_count % 2 != 0) {
        free(s_indices);
        return 0;
    }

    long long ways = 1;

    for (int i = 0; i < s_count / 2 - 1; i++) {
        long long choices = (long long)s_indices[2 * i + 2] - s_indices[2 * i + 1];
        ways = (ways * choices) % MOD;
    }

    free(s_indices);
    return ways;
}