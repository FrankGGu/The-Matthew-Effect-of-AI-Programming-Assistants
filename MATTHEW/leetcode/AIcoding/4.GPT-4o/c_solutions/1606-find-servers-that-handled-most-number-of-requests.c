#include <stdio.h>
#include <stdlib.h>

int* busiestServers(int k, int* arrival, int arrivalSize, int* load, int loadSize, int* returnSize) {
    int* count = (int*)calloc(k, sizeof(int));
    int* result = NULL;
    int maxCount = 0;

    int* endTime = (int*)malloc(sizeof(int) * k);
    for (int i = 0; i < k; i++) endTime[i] = -1;

    for (int i = 0; i < arrivalSize; i++) {
        int serverIndex = i % k;
        int j = 0;

        while (j < k) {
            int actualServer = (serverIndex + j) % k;
            if (endTime[actualServer] < arrival[i]) {
                count[actualServer]++;
                endTime[actualServer] = arrival[i] + load[i];
                break;
            }
            j++;
        }
    }

    for (int i = 0; i < k; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
        }
    }

    int size = 0;
    for (int i = 0; i < k; i++) {
        if (count[i] == maxCount) {
            size++;
        }
    }

    result = (int*)malloc(sizeof(int) * size);
    int index = 0;
    for (int i = 0; i < k; i++) {
        if (count[i] == maxCount) {
            result[index++] = i;
        }
    }

    free(count);
    free(endTime);
    *returnSize = size;
    return result;
}