#include <stdio.h>
#include <stdlib.h>

int* findRightInterval(int* intervals, int intervalsSize, int* returnSize) {
    int* result = (int*)malloc(intervalsSize * sizeof(int));
    int* indices = (int*)malloc(intervalsSize * sizeof(int));

    for (int i = 0; i < intervalsSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < intervalsSize - 1; i++) {
        for (int j = i + 1; j < intervalsSize; j++) {
            if (intervals[indices[i]] > intervals[indices[j]]) {
                int temp = indices[i];
                indices[i] = indices[j];
                indices[j] = temp;
            }
        }
    }

    for (int i = 0; i < intervalsSize; i++) {
        int left = 0;
        int right = intervalsSize - 1;
        int minIndex = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (intervals[indices[mid]] >= intervals[i]) {
                minIndex = indices[mid];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        result[i] = minIndex;
    }

    *returnSize = intervalsSize;
    free(indices);
    return result;
}