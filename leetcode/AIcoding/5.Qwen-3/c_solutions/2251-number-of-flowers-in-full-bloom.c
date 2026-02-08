#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* fullBloomFlowers(int** flowers, int flowersSize, int* people, int peopleSize, int* returnSize) {
    int* start = (int*)malloc(flowersSize * sizeof(int));
    int* end = (int*)malloc(flowersSize * sizeof(int));

    for (int i = 0; i < flowersSize; i++) {
        start[i] = flowers[i][0];
        end[i] = flowers[i][1];
    }

    qsort(start, flowersSize, sizeof(int), compare);
    qsort(end, flowersSize, sizeof(int), compare);

    int* result = (int*)malloc(peopleSize * sizeof(int));

    for (int i = 0; i < peopleSize; i++) {
        int t = people[i];
        int l = 0, r = flowersSize - 1;
        int start_count = 0;
        while (l <= r) {
            int mid = l + (r - l) / 2;
            if (start[mid] <= t) {
                start_count = mid + 1;
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        l = 0, r = flowersSize - 1;
        int end_count = 0;
        while (l <= r) {
            int mid = l + (r - l) / 2;
            if (end[mid] < t) {
                end_count = mid + 1;
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        result[i] = start_count - end_count;
    }

    *returnSize = peopleSize;
    free(start);
    free(end);
    return result;
}