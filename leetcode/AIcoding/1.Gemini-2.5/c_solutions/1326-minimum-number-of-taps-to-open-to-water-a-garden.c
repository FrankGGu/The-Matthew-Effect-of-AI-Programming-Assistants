#include <stdlib.h> // For calloc, free

static inline int max(int a, int b) {
    return a > b ? a : b;
}

static inline int min(int a, int b) {
    return a < b ? a : b;
}

int minTaps(int n, int* ranges, int rangesSize) {
    int* max_reach = (int*)calloc(n + 1, sizeof(int));
    if (max_reach == NULL) {
        return -1; 
    }

    for (int i = 0; i <= n; ++i) {
        int left = max(0, i - ranges[i]);
        int right = min(n, i + ranges[i]);
        max_reach[left] = max(max_reach[left], right);
    }

    int taps = 0;
    int current_end = 0;
    int farthest_can_reach = 0;

    for (int i = 0; i <= n; ++i) {
        if (i > farthest_can_reach) {
            free(max_reach);
            return -1;
        }

        farthest_can_reach = max(farthest_can_reach, max_reach[i]);

        if (i == current_end) {
            taps++;
            current_end = farthest_can_reach;

            if (current_end <= i && i < n) {
                free(max_reach);
                return -1;
            }
        }

        if (current_end >= n) {
            free(max_reach);
            return taps;
        }
    }

    free(max_reach);
    return -1;
}