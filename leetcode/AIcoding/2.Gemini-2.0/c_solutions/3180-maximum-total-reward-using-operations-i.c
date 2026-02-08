#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumTotalReward(int* reward, int rewardSize, int k) {
    int sum = 0;
    for (int i = 0; i < rewardSize; i++) {
        sum += reward[i];
    }

    if (k == 0) {
        return sum;
    }

    int* arr = (int*)malloc(rewardSize * sizeof(int));
    for (int i = 0; i < rewardSize; i++) {
        arr[i] = reward[i];
    }

    for (int i = 0; i < k; i++) {
        int minIndex = 0;
        for (int j = 1; j < rewardSize; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        arr[minIndex] = -arr[minIndex];
    }

    int result = 0;
    for (int i = 0; i < rewardSize; i++) {
        result += arr[i];
    }

    free(arr);
    return result;
}