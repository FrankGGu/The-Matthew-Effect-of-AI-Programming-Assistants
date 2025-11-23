#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minWastedSpace(int* packages, int packagesSize, int** boxes, int boxesSize, int* boxesColSize) {
    qsort(packages, packagesSize, sizeof(int), cmp);

    long long total = 0;
    for (int i = 0; i < packagesSize; i++) {
        total += packages[i];
    }

    long long min_waste = -1;

    for (int i = 0; i < boxesSize; i++) {
        qsort(boxes[i], boxesColSize[i], sizeof(int), cmp);

        if (boxes[i][boxesColSize[i] - 1] < packages[packagesSize - 1]) {
            continue;
        }

        long long waste = 0;
        int pos = 0;

        for (int j = 0; j < boxesColSize[i]; j++) {
            int box = boxes[i][j];
            int left = pos, right = packagesSize - 1;
            int idx = -1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (packages[mid] <= box) {
                    idx = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (idx == -1) continue;

            long long count = idx - pos + 1;
            waste += (long long)box * count;
            pos = idx + 1;

            if (pos >= packagesSize) break;
        }

        if (pos < packagesSize) continue;

        waste -= total;
        if (min_waste == -1 || waste < min_waste) {
            min_waste = waste;
        }
    }

    return min_waste == -1 ? -1 : min_waste % 1000000007;
}