#include <stdio.h>
#include <stdlib.h>

int numberOfWays(int** people, int peopleSize, int* peopleColSize) {
    int n = peopleSize;
    int* x = (int*)malloc(n * sizeof(int));
    int* y = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        x[i] = people[i][0];
        y[i] = people[i][1];
    }

    int* sorted_x = (int*)malloc(n * sizeof(int));
    int* sorted_y = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        sorted_x[i] = x[i];
        sorted_y[i] = y[i];
    }

    qsort(sorted_x, n, sizeof(int), (int (*)(const void*, const void*))strcmp);
    qsort(sorted_y, n, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int* rank_x = (int*)malloc(n * sizeof(int));
    int* rank_y = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; ++i) {
        rank_x[i] = 0;
        for (int j = 0; j < n; ++j) {
            if (sorted_x[j] == x[i]) {
                rank_x[i] = j + 1;
                break;
            }
        }
    }

    for (int i = 0; i < n; ++i) {
        rank_y[i] = 0;
        for (int j = 0; j < n; ++j) {
            if (sorted_y[j] == y[i]) {
                rank_y[i] = j + 1;
                break;
            }
        }
    }

    int* tree = (int*)calloc(n + 2, sizeof(int));

    int count = 0;

    for (int i = 0; i < n; ++i) {
        int r = rank_y[i];
        int sum = 0;
        while (r > 0) {
            sum += tree[r];
            r -= r & -r;
        }
        count += sum;
        r = rank_y[i];
        while (r <= n) {
            tree[r] += 1;
            r += r & -r;
        }
    }

    free(x);
    free(y);
    free(sorted_x);
    free(sorted_y);
    free(rank_x);
    free(rank_y);
    free(tree);

    return count;
}