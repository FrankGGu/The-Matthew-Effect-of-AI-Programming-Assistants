#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* longestObstacleCourseAtEachPosition(int* obstacles, int obstaclesSize, int* returnSize) {
    int* result = (int*)malloc(obstaclesSize * sizeof(int));
    int* tail = (int*)malloc(obstaclesSize * sizeof(int));
    int len = 0;

    for (int i = 0; i < obstaclesSize; i++) {
        int obstacle = obstacles[i];
        int left = 0;
        int right = len;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (tail[mid] <= obstacle) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if (left == len) {
            tail[len++] = obstacle;
        } else {
            tail[left] = obstacle;
        }

        result[i] = left + 1;
    }

    *returnSize = obstaclesSize;
    free(tail);
    return result;
}