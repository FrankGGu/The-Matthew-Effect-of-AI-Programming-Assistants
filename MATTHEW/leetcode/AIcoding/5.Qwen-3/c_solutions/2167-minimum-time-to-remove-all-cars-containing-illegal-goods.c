#include <stdio.h>
#include <stdlib.h>

int minimumTime(int* blocks, int blocksSize, int k) {
    int n = blocksSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + (blocks[i] == 0 ? 0 : 1);
    }

    int left = 0, right = n;
    int result = n;

    while (left <= right) {
        int mid = (left + right) / 2;
        int count = 0;
        int last = -k;
        for (int i = 1; i <= n; ++i) {
            if (prefix[i] - prefix[i - k] > prefix[last + k] - prefix[last]) {
                count++;
                last = i - 1;
            }
        }
        if (count <= mid) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    free(prefix);
    return result;
}