#include <stdlib.h>
#include <string.h>

#define MAX_N 100005

int cmp(const void *a, const void *b) {
    return *(long long*)a - *(long long*)b;
}

int longestSquareStreak(int* nums, int numsSize) {
    long long arr[MAX_N];
    int n = numsSize;
    for (int i = 0; i < n; i++) {
        arr[i] = (long long)nums[i];
    }

    qsort(arr, n, sizeof(long long), cmp);

    int maxStreak = 0;
    int visited[MAX_N] = {0};

    for (int i = 0; i < n; i++) {
        if (visited[i]) continue;

        long long current = arr[i];
        int streak = 1;
        visited[i] = 1;

        while (1) {
            long long next = current * current;
            if (next > 10000000000LL) break;

            int left = i + 1, right = n - 1;
            int found = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (arr[mid] == next) {
                    found = mid;
                    break;
                } else if (arr[mid] < next) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (found != -1 && !visited[found]) {
                streak++;
                current = next;
                visited[found] = 1;
            } else {
                break;
            }
        }

        if (streak > maxStreak) {
            maxStreak = streak;
        }
    }

    return maxStreak >= 2 ? maxStreak : -1;
}