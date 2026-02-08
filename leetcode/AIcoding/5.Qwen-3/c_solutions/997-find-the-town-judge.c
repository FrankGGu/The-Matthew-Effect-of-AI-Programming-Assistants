#include <stdio.h>
#include <stdlib.h>

int findJudge(int n, int* trust, int trustSize, int* trustColSize) {
    int* inDegree = (int*)calloc(n, sizeof(int));
    int* outDegree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < trustSize; i++) {
        int a = trust[i][0] - 1;
        int b = trust[i][1] - 1;
        outDegree[a]++;
        inDegree[b]++;
    }

    for (int i = 0; i < n; i++) {
        if (inDegree[i] == n - 1 && outDegree[i] == 0) {
            free(inDegree);
            free(outDegree);
            return i + 1;
        }
    }

    free(inDegree);
    free(outDegree);
    return -1;
}