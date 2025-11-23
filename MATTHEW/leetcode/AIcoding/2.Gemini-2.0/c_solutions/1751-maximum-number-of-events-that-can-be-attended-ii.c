#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return ((int *)a)[1] - ((int *)b)[1];
}

int binarySearch(int events[][3], int n, int target) {
    int left = 0, right = n - 1, ans = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (events[mid][1] < target) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return ans;
}

int maxValue(int events[][3], int eventsSize, int eventsColSize, int k) {
    qsort(events, eventsSize, sizeof(events[0]), cmp);
    int dp[eventsSize + 1][k + 1];
    for (int i = 0; i <= eventsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= eventsSize; i++) {
        for (int j = 1; j <= k; j++) {
            int prevIndex = binarySearch(events, i - 1, events[i - 1][0]);
            int include = events[i - 1][2];
            if (prevIndex != -1) {
                include += dp[prevIndex + 1][j - 1];
            }

            dp[i][j] = (dp[i - 1][j] > include) ? dp[i - 1][j] : include;
        }
    }

    return dp[eventsSize][k];
}