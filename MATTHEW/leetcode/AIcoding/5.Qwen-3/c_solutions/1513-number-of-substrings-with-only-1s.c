#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubstringsWithOnly1s(char* s) {
    int n = strlen(s);
    long long count = 0;
    long long consecutiveOnes = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            consecutiveOnes++;
            count += consecutiveOnes;
        } else {
            consecutiveOnes = 0;
        }
    }
    return (int)count;
}