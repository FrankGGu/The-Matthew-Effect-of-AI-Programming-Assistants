#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findJudge(int n, int** trust, int trustSize, int* trustColSize) {
    if (n == 1 && trustSize == 0) return 1;

    int* inDegree = (int*)calloc(n + 1, sizeof(int));
    int* outDegree = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i < trustSize; i++) {
        outDegree[trust[i][0]]++;
        inDegree[trust[i][1]]++;
    }

    for (int i = 1; i <= n; i++) {
        if (inDegree[i] == n - 1 && outDegree[i] == 0) {
            free(inDegree);
            free(outDegree);
            return i;
        }
    }

    free(inDegree);
    free(outDegree);
    return -1;
}