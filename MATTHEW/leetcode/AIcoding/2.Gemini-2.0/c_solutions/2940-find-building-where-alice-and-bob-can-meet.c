#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findMeetingBuildings(int* heights, int heightsSize, int* queries, int queriesSize, int* returnSize){
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i * 2];
        int b = queries[i * 2 + 1];

        if (heights[a] == heights[b]) {
            result[(*returnSize)++] = -1;
            continue;
        }

        int start = (a < b) ? a : b;
        int end = (a < b) ? b : a;
        int max_height = 0;

        for (int j = start + 1; j < end; j++) {
            if (heights[j] > heights[start] && heights[j] > heights[end]) {
                max_height = -1;
                break;
            }
            if (heights[j] > max_height) {
                max_height = heights[j];
            }
        }

        if (max_height == -1) {
            result[(*returnSize)++] = -1;
        } else {
            result[(*returnSize)++] = end;
        }
    }

    return result;
}