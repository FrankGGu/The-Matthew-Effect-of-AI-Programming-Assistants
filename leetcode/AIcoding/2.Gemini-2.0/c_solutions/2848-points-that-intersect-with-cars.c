#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfPoints(int** nums, int numsSize, int* numsColSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i][1] > max_val) {
            max_val = nums[i][1];
        }
    }

    int* points = (int*)calloc(max_val + 1, sizeof(int));
    if (points == NULL) {
        return 0;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = nums[i][0]; j <= nums[i][1]; j++) {
            points[j] = 1;
        }
    }

    int count = 0;
    for (int i = 1; i <= max_val; i++) {
        if (points[i] == 1) {
            count++;
        }
    }

    free(points);
    return count;
}