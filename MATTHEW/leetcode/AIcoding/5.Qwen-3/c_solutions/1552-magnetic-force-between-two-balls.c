#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int canPlace(int* position, int n, int m, int d) {
    int count = 1;
    int last = position[0];
    for (int i = 1; i < n; i++) {
        if (position[i] - last >= d) {
            count++;
            last = position[i];
            if (count == m) {
                return 1;
            }
        }
    }
    return 0;
}

int maxDistance(int* position, int positionSize, int m) {
    qsort(position, positionSize, sizeof(int), compare);
    int left = 0;
    int right = position[positionSize - 1] - position[0];
    int result = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canPlace(position, positionSize, m, mid)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
}