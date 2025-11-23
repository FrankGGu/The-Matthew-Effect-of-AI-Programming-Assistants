#include <stdio.h>
#include <stdlib.h>

int numberOfWays(int* corridor, int corridorSize) {
    int MOD = 1000000007;
    int count = 0;
    int seats = 0;
    int result = 1;
    for (int i = 0; i < corridorSize; i++) {
        if (corridor[i] == 1) {
            seats++;
        }
        if (seats == 2) {
            count++;
            seats = 0;
        }
    }
    if (seats != 0 || count < 1) {
        return 0;
    }
    int* ways = (int*)malloc((count - 1) * sizeof(int));
    for (int i = 0; i < count - 1; i++) {
        ways[i] = 0;
    }
    int j = 0;
    for (int i = 0; i < corridorSize; i++) {
        if (corridor[i] == 1) {
            if (j < count - 1) {
                ways[j] = 0;
            }
            j++;
        } else if (j >= 2 && j < count) {
            ways[j - 2]++;
        }
    }
    for (int i = 0; i < count - 1; i++) {
        result = (result * (ways[i] + 1)) % MOD;
    }
    free(ways);
    return result;
}