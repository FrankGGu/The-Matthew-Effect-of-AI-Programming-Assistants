#include <stdio.h>
#include <stdlib.h>

int consecutiveNumbersSum(int N) {
    int count = 0;
    int k = 1;
    while (k * (k + 1) / 2 <= N) {
        if ((N - k * (k + 1) / 2) % k == 0) {
            count++;
        }
        k++;
    }
    return count;
}