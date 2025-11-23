#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int chalkReplacer(int* chalk, int chalkSize, int k){
    long long sum = 0;
    for (int i = 0; i < chalkSize; i++) {
        sum += chalk[i];
    }

    k %= sum;

    for (int i = 0; i < chalkSize; i++) {
        if (k < chalk[i]) {
            return i;
        }
        k -= chalk[i];
    }

    return 0;
}