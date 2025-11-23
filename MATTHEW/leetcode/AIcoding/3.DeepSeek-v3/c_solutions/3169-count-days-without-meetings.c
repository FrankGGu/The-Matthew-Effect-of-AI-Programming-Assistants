#include <stdlib.h>

int cmp(const void* a, const void* b) {
    int* first = *(int**)a;
    int* second = *(int**)b;
    if (first[0] != second[0]) {
        return first[0] - second[0];
    }
    return first[1] - second[1];
}

int countDays(int days, int** meetings, int meetingsSize, int* meetingsColSize) {
    qsort(meetings, meetingsSize, sizeof(int*), cmp);

    int busyDays = 0;
    int currentEnd = -1;

    for (int i = 0; i < meetingsSize; i++) {
        int start = meetings[i][0];
        int end = meetings[i][1];

        if (start > currentEnd) {
            busyDays += (end - start + 1);
            currentEnd = end;
        } else {
            if (end > currentEnd) {
                busyDays += (end - currentEnd);
                currentEnd = end;
            }
        }
    }

    return days - busyDays;
}