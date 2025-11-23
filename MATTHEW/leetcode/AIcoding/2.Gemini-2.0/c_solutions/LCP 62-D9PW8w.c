#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int transportationHub(int n, int** roads, int roadsSize, int* roadsColSize) {
    int* inDegree = (int*)calloc(n, sizeof(int));
    int* outDegree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < roadsSize; i++) {
        outDegree[roads[i][0]]++;
        inDegree[roads[i][1]]++;
    }

    for (int i = 0; i < n; i++) {
        if (inDegree[i] == n - 1 && outDegree[i] == 0) {
            bool valid = true;
            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                bool found = false;
                for (int k = 0; k < roadsSize; k++) {
                    if (roads[k][0] == j && roads[k][1] == i) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                free(inDegree);
                free(outDegree);
                return i;
            }
        }
    }

    free(inDegree);
    free(outDegree);
    return -1;
}