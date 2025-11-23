#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int check(int* position, int n, int m, int force) {
    int count = 1;
    int last_pos = position[0];
    for (int i = 1; i < n; i++) {
        if (position[i] - last_pos >= force) {
            count++;
            last_pos = position[i];
            if (count == m) {
                return 1;
            }
        }
    }
    return 0;
}

int maxDistance(int* position, int n, int m) {
    qsort(position, n, sizeof(int), compare);

    int low = 1;
    int high = position[n - 1] - position[0];
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(position, n, m, mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}