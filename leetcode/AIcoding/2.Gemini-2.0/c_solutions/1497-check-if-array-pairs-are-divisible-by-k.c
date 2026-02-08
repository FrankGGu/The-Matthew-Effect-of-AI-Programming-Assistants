#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canArrange(int* arr, int arrSize, int k) {
    int remainders[k];
    for (int i = 0; i < k; i++) {
        remainders[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        int remainder = (arr[i] % k + k) % k;
        remainders[remainder]++;
    }

    if (remainders[0] % 2 != 0) {
        return false;
    }

    for (int i = 1; i <= k / 2; i++) {
        if (remainders[i] != remainders[k - i]) {
            return false;
        }
    }

    return true;
}