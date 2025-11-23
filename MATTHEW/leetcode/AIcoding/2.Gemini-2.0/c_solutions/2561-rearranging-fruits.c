#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

long long minCost(int* basket1, int basket1Size, int* basket2, int basket2Size) {
    int count[200001] = {0};
    int minVal = 200001;
    for (int i = 0; i < basket1Size; i++) {
        count[basket1[i]]++;
        minVal = min(minVal, basket1[i]);
    }
    for (int i = 0; i < basket2Size; i++) {
        count[basket2[i]]--;
        minVal = min(minVal, basket2[i]);
    }

    int arr[200001];
    int arrSize = 0;
    for (int i = 1; i <= 200000; i++) {
        if (count[i] != 0) {
            if (abs(count[i]) % 2 != 0) {
                return -1;
            }
            for (int j = 0; j < abs(count[i] / 2); j++) {
                arr[arrSize++] = i;
            }
        }
    }

    long long cost = 0;
    for (int i = 0; i < arrSize; i++) {
        cost += min(arr[i], 2 * minVal);
    }

    return cost;
}