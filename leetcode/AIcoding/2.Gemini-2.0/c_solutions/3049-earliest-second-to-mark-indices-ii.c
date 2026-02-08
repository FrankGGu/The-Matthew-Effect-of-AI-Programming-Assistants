#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long earliestSecondToMarkIndices(int *nums, int numsSize, int *changeIndices, int changeIndicesSize) {
    long long left = 1, right = changeIndicesSize;
    long long ans = -1;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        bool possible = false;

        int marked[numsSize + 1];
        memset(marked, 0, sizeof(marked));

        int lastOccurrences[numsSize + 1];
        memset(lastOccurrences, 0, sizeof(lastOccurrences));

        for (int i = 1; i <= mid; i++) {
            lastOccurrences[changeIndices[i - 1]] = i;
        }

        int count = 0;
        for (int i = 1; i <= numsSize; i++) {
            if (lastOccurrences[i] == 0) {
                count += nums[i - 1];
            }
        }

        if (count > mid) {
            left = mid + 1;
            continue;
        }

        long long available = mid - count;

        for (int i = 1; i <= mid; i++) {
            int index = changeIndices[i - 1];
            if (lastOccurrences[index] == i) {
                if (available >= nums[index - 1]) {
                    available -= nums[index - 1];
                    marked[index] = 1;
                } else {
                    available = -1;
                    break;
                }
            } else {
                available--;
                if (available < 0) {
                    break;
                }
            }
        }

        bool allMarked = true;
        for (int i = 1; i <= numsSize; i++) {
            if (lastOccurrences[i] != 0 && marked[i] == 0) {
                allMarked = false;
                break;
            }
        }

        if (available >= 0 && allMarked) {
            possible = true;
        }

        if (possible) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}