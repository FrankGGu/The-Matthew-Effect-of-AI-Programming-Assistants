#include <stdio.h>
#include <stdlib.h>

int findScore(int* nums, int numsSize) {
    int* visited = (int*)calloc(numsSize, sizeof(int));
    int score = 0;
    int i, j;

    for (i = 0; i < numsSize; i++) {
        if (!visited[i]) {
            int minIndex = i;
            for (j = i + 1; j < numsSize; j++) {
                if (nums[j] < nums[minIndex]) {
                    minIndex = j;
                }
            }
            score += nums[minIndex];
            visited[minIndex] = 1;
            for (j = 0; j < numsSize; j++) {
                if (j != minIndex && nums[j] == nums[minIndex]) {
                    visited[j] = 1;
                }
            }
        }
    }

    free(visited);
    return score;
}