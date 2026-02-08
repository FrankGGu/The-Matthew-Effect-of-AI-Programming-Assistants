#include <stdlib.h>
#include <limits.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minDistance(int* nums, int numsSize) {
    int n = numsSize;
    int* sum = (int*)malloc(n * sizeof(int));
    int* diff = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        sum[i] = nums[i] + i;
        diff[i] = nums[i] - i;
    }

    qsort(sum, n, sizeof(int), cmp);
    qsort(diff, n, sizeof(int), cmp);

    int max_sum = sum[n-1] - sum[0];
    int max_diff = diff[n-1] - diff[0];

    free(sum);
    free(diff);

    return (max_sum > max_diff) ? max_sum : max_diff;
}

int minSumDistance(int** points, int pointsSize, int* pointsColSize) {
    int n = pointsSize;
    int* x = (int*)malloc(n * sizeof(int));
    int* y = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        x[i] = points[i][0];
        y[i] = points[i][1];
    }

    int max_x = minDistance(x, n);
    int max_y = minDistance(y, n);

    free(x);
    free(y);

    return (max_x > max_y) ? max_x : max_y;
}