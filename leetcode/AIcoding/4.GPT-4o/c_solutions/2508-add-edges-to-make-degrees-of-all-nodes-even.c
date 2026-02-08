#include <stdbool.h>

bool isPossible(int n, int** edges, int edgesSize, int* edgesColSize) {
    int degree[n];
    for (int i = 0; i < n; i++) {
        degree[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    int oddCount = 0;
    for (int i = 0; i < n; i++) {
        if (degree[i] % 2 != 0) {
            oddCount++;
        }
    }

    return oddCount == 0 || oddCount == 2;
}