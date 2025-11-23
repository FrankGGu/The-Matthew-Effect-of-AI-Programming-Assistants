#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int check(int *position, int n, int m, int force) {
    int count = 1;
    int last_pos = position[0];
    for (int i = 1; i < n; i++) {
        if (position[i] - last_pos >= force) {
            count++;
            last_pos = position[i];
        }
    }
    return count >= m;
}

int maxDistance(int *position, int positionSize, int m) {
    qsort(position, positionSize, sizeof(int), cmp);
    int left = 1, right = position[positionSize - 1] - position[0];
    int ans = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(position, positionSize, m, mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return ans;
}