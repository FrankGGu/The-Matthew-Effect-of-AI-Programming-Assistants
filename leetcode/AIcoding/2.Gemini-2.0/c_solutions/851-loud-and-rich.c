#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* loudAndRich(int** richer, int richerSize, int* richerColSize, int n, int* returnSize) {
    int i, j;
    int* result = (int*)malloc(n * sizeof(int));
    int* quiet = (int*)malloc(n * sizeof(int));

    int* in_degree = (int*)calloc(n, sizeof(int));
    int** adj_list = (int**)malloc(n * sizeof(int*));
    int* adj_sizes = (int*)calloc(n, sizeof(int));

    for (i = 0; i < n; i++) {
        adj_list[i] = (int*)malloc(n * sizeof(int));
    }

    for (i = 0; i < richerSize; i++) {
        int u = richer[i][1];
        int v = richer[i][0];
        adj_list[u][adj_sizes[u]++] = v;
        in_degree[v]++;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;

    for (i = 0; i < n; i++) {
        quiet[i] = i;
        if (in_degree[i] == 0) {
            queue[tail++] = i;
        }
    }

    while (head < tail) {
        int u = queue[head++];

        for (i = 0; i < adj_sizes[u]; i++) {
            int v = adj_list[u][i];
            if (quiet[u] < quiet[v]) {
                quiet[v] = quiet[u];
            }
            if (--in_degree[v] == 0) {
                queue[tail++] = v;
            }
        }
    }

    for (i = 0; i < n; i++) {
        result[i] = quiet[i];
    }

    *returnSize = n;

    for (i = 0; i < n; i++) {
        free(adj_list[i]);
    }
    free(adj_list);
    free(adj_sizes);
    free(in_degree);
    free(queue);
    free(quiet);

    return result;
}