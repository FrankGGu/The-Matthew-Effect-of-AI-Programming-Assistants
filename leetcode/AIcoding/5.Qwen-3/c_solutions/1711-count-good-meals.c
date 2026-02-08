#include <stdio.h>
#include <stdlib.h>

int countPairs(int* arr, int arrSize) {
    int mod = 1000000007;
    int maxSum = 2048;
    int count[2049] = {0};
    int result = 0;

    for (int i = 0; i < arrSize; i++) {
        int num = arr[i];
        for (int j = 0; j <= 2048; j++) {
            int complement = j - num;
            if (complement >= 0 && complement <= 2048) {
                result = (result + count[complement]) % mod;
            }
        }
        count[num]++;
    }

    return result;
}