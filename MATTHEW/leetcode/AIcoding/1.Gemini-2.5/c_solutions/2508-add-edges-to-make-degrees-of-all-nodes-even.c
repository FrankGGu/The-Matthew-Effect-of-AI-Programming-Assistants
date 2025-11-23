#include <stdbool.h>
#include <stdlib.h>

bool isPossible(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* degree = (int*)calloc(n + 1, sizeof(int));
    if (degree == NULL) {
        return false; 
    }

    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    int odd_count = 0;
    for (int i = 1; i <= n; i++) {
        if (degree[i] % 2 != 0) {
            odd_count++;
        }
    }

    free(degree);

    if (odd_count == 0 || odd_count == 2 || odd_count == 4) {
        return true;
    } else {
        return false;
    }
}