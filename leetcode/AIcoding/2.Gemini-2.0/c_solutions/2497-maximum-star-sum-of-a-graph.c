#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxStarSum(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize, int k) {
    int* adj_count = (int*)calloc(valsSize, sizeof(int));
    int** adj = (int**)malloc(valsSize * sizeof(int*));
    for (int i = 0; i < valsSize; i++) {
        adj[i] = (int*)malloc(valsSize * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_count[u]++] = v;
        adj[v][adj_count[v]++] = u;
    }

    int max_sum = -1e9;
    for (int i = 0; i < valsSize; i++) {
        int current_sum = vals[i];
        int* neighbors = (int*)malloc(adj_count[i] * sizeof(int));
        for (int j = 0; j < adj_count[i]; j++) {
            neighbors[j] = vals[adj[i][j]];
        }

        for (int x = 0; x < adj_count[i]; x++) {
            for (int y = x + 1; y < adj_count[i]; y++) {
                if (neighbors[x] < neighbors[y]) {
                    int temp = neighbors[x];
                    neighbors[x] = neighbors[y];
                    neighbors[y] = temp;
                }
            }
        }

        int count = 0;
        for (int j = 0; j < adj_count[i] && count < k; j++) {
            if (neighbors[j] > 0) {
                current_sum += neighbors[j];
                count++;
            }
        }

        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
        free(neighbors);
    }

    for (int i = 0; i < valsSize; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adj_count);
    return max_sum;
}