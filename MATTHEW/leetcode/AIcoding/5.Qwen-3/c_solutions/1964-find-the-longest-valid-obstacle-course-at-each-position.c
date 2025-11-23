#include <stdio.h>
#include <stdlib.h>

int* longestObstacleCourseAtEachPosition(int* obstacles, int obstaclesSize, int* returnSize) {
    int* result = (int*)malloc(obstaclesSize * sizeof(int));
    int* tails = (int*)malloc(obstaclesSize * sizeof(int));
    int length = 0;

    for (int i = 0; i < obstaclesSize; i++) {
        int left = 0, right = length;
        while (left < right) {
            int mid = (left + right) / 2;
            if (tails[mid] <= obstacles[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if (left == length) {
            tails[length++] = obstacles[i];
        } else {
            tails[left] = obstacles[i];
        }

        result[i] = left + 1;
    }

    free(tails);
    *returnSize = obstaclesSize;
    return result;
}