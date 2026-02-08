#include <stdio.h>
#include <stdlib.h>

int maxNetworkRank(int* coordinates, int coordinatesSize, int** roads, int roadsSize, int* roadsColSize) {
    int maxRank = 0;
    int n = coordinatesSize;
    int* degree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        degree[u]++;
        degree[v]++;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int rank = degree[i] + degree[j];
            int connected = 0;
            for (int k = 0; k < roadsSize; k++) {
                if ((roads[k][0] == i && roads[k][1] == j) || (roads[k][0] == j && roads[k][1] == i)) {
                    connected = 1;
                    break;
                }
            }
            if (connected) {
                rank--;
            }
            if (rank > maxRank) {
                maxRank = rank;
            }
        }
    }

    free(degree);
    return maxRank;
}