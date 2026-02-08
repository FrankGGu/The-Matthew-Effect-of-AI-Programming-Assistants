#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfWays(char * corridor) {
    long long seats = 0;
    long long plants_between = 0;
    long long ways = 1;
    long long mod = 1000000007;

    for (int i = 0; corridor[i] != '\0'; i++) {
        if (corridor[i] == 'S') {
            seats++;
            if (seats > 2 && seats % 2 == 1) {
                ways = (ways * (plants_between + 1)) % mod;
            }
            plants_between = 0;
        } else if (seats >= 2 && seats % 2 == 0) {
            plants_between++;
        }
    }

    if (seats < 2 || seats % 2 != 0) {
        return 0;
    }

    return (int)ways;
}