#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* target, int targetSize, int* arr, int arrSize) {
    int* pos = (int*)malloc(sizeof(int) * 100001);
    for (int i = 0; i <= 100000; i++) {
        pos[i] = -1;
    }
    for (int i = 0; i < targetSize; i++) {
        pos[target[i]] = i;
    }

    int* sub = (int*)malloc(sizeof(int) * arrSize);
    int subSize = 0;
    for (int i = 0; i < arrSize; i++) {
        if (pos[arr[i]] != -1) {
            sub[subSize++] = pos[arr[i]];
        }
    }

    int* tails = (int*)malloc(sizeof(int) * subSize);
    int len = 0;
    for (int i = 0; i < subSize; i++) {
        int x = sub[i];
        int left = 0, right = len;
        while (left < right) {
            int mid = (left + right) / 2;
            if (tails[mid] < x) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        tails[left] = x;
        if (left == len) {
            len++;
        }
    }

    free(pos);
    free(sub);
    free(tails);

    return targetSize - len;
}