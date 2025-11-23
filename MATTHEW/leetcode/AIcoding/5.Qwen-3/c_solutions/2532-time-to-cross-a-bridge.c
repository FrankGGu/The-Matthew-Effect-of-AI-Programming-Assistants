#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int left;
    int right;
} Pair;

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findCrossingTime(int* workers, int workersSize, int* boxes, int boxesSize) {
    int time = 0;
    int left = 0, right = 0;
    int i = 0, j = 0;
    int n = workersSize, m = boxesSize;

    qsort(workers, workersSize, sizeof(int), compare);
    qsort(boxes, boxesSize, sizeof(int), compare);

    while (i < n || j < m) {
        if (i < n && workers[i] <= time) {
            left++;
            i++;
        } else if (j < m && boxes[j] <= time) {
            right++;
            j++;
        } else {
            int nextLeft = (i < n) ? workers[i] : 1e9;
            int nextRight = (j < m) ? boxes[j] : 1e9;
            time = fmin(nextLeft, nextRight);
        }

        if (left > 0 && right == 0) {
            time += 1;
            left--;
        } else if (right > 0 && left == 0) {
            time += 1;
            right--;
        }
    }

    return time;
}