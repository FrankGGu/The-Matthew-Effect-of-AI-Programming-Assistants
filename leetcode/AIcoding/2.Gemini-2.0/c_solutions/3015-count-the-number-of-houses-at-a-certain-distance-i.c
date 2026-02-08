#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countOfPairs(int n, int x, int y, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        result[i] = 0;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            int dist1 = abs(i - j);
            int dist2 = abs(i - x) + abs(y - j) + 1;
            int dist3 = abs(i - y) + abs(x - j) + 1;
            int min_dist = dist1;
            if (dist2 < min_dist) {
                min_dist = dist2;
            }
            if (dist3 < min_dist) {
                min_dist = dist3;
            }
            result[min_dist - 1] += 2;
        }
    }

    *returnSize = n;
    return result;
}