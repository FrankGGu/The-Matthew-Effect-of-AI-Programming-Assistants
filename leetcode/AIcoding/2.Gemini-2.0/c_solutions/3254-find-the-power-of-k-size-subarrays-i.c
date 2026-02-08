#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findThePowerOfKthSubarray(int* arr, int arrSize, int k) {
    int power = 0;
    for (int i = 0; i <= arrSize - k; i++) {
        int subarraySum = 0;
        for (int j = i; j < i + k; j++) {
            subarraySum += arr[j];
        }
        power = power ^ subarraySum;
    }
    return power;
}