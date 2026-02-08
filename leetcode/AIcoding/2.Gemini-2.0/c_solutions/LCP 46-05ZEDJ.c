#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* volunteerDeployment(int* finalCnt, int m, int** edges, int edgesSize, int* edgesColSize, long long* addition, int additionSize) {
    int n = additionSize + 1;
    long long* diff = (long long*)calloc(n, sizeof(long long));
    long long sum = 0;
    for (int i = 0; i < additionSize; i++) {
        diff[0] += addition[i];
        diff[i + 1] -= addition[i];
    }

    int* deg = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        deg[edges[i][0] - 1]++;
        deg[edges[i][1] - 1]++;
    }

    long long a = 1, b = 0;
    for (int i = 0; i < n; i++) {
        b += diff[i];
        sum += b;
    }

    for (int i = 0; i < edgesSize; i++) {
        a += 2;
    }

    long long x = (*finalCnt - b) / a;

    int* ans = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        ans[i] = x;
    }

    for (int i = 0; i < additionSize; i++) {
        ans[i + 1] += addition[i];
    }

    free(deg);
    free(diff);

    return ans;
}