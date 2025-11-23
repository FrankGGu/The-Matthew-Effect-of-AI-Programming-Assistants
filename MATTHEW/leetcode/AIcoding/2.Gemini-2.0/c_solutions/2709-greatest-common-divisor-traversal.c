#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

void dfs(int node, int* visited, int* adj[], int adjSize[], int n) {
    visited[node] = 1;
    for (int i = 0; i < adjSize[node]; i++) {
        int neighbor = adj[node][i];
        if (!visited[neighbor]) {
            dfs(neighbor, visited, adj, adjSize, n);
        }
    }
}

int canTraverseAllPairs(int* nums, int numsSize) {
    if (numsSize == 1) return 1;

    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) return 0;
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    int* adj[numsSize];
    int adjSize[numsSize];
    for (int i = 0; i < numsSize; i++) {
        adjSize[i] = 0;
        adj[i] = (int*)malloc(numsSize * sizeof(int));
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (gcd(nums[i], nums[j]) > 1) {
                adj[i][adjSize[i]++] = j;
                adj[j][adjSize[j]++] = i;
            }
        }
    }

    int* visited = (int*)calloc(numsSize, sizeof(int));
    dfs(0, visited, adj, adjSize, numsSize);

    for (int i = 0; i < numsSize; i++) {
        if (!visited[i]) {
            for (int j = 0; j < numsSize; j++) {
                free(adj[j]);
            }
            free(visited);
            return 0;
        }
    }

    for (int j = 0; j < numsSize; j++) {
        free(adj[j]);
    }

    free(visited);
    return 1;
}