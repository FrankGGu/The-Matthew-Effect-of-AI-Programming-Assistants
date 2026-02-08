#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int diff_a = ((int*)a)[0] - ((int*)a)[1];
    int diff_b = ((int*)b)[0] - ((int*)b)[1];
    return diff_b - diff_a;
}

int miceAndCheese(int* reward1, int reward1Size, int* reward2, int reward2Size, int k) {
    int n = reward1Size;
    int** diff = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        diff[i] = (int*)malloc(2 * sizeof(int));
        diff[i][0] = reward1[i];
        diff[i][1] = reward2[i];
    }

    qsort(diff, n, sizeof(int*), cmp);

    int ans = 0;
    for (int i = 0; i < k; i++) {
        ans += diff[i][0];
    }
    for (int i = k; i < n; i++) {
        ans += diff[i][1];
    }

    for (int i = 0; i < n; i++) {
        free(diff[i]);
    }
    free(diff);

    return ans;
}