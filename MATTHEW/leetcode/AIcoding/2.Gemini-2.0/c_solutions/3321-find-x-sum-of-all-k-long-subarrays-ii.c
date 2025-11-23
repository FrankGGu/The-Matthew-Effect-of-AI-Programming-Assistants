#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long subArrayXOR(int* arr, int arrSize, int k, int x) {
    long long result = 0;
    for (int i = 0; i <= arrSize - k; i++) {
        int xor_sum = 0;
        for (int j = i; j < i + k; j++) {
            xor_sum ^= arr[j];
        }
        if (xor_sum == x) {
            result++;
        }
    }
    return result;
}