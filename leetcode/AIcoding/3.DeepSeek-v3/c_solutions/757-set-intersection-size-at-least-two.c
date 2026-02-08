#include <stdlib.h>

int cmp(const void* a, const void* b) {
    int* intervalA = *(int**)a;
    int* intervalB = *(int**)b;
    if (intervalA[1] == intervalB[1]) {
        return intervalB[0] - intervalA[0];
    }
    return intervalA[1] - intervalB[1];
}

int intersectionSizeTwo(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int result = 0;
    int largest = -1;
    int second_largest = -1;

    for (int i = 0; i < intervalsSize; i++) {
        int start = intervals[i][0];
        int end = intervals[i][1];

        if (start > largest) {
            result += 2;
            second_largest = end - 1;
            largest = end;
        } else if (start > second_largest) {
            result += 1;
            second_largest = largest;
            largest = end;
        }
    }

    return result;
}