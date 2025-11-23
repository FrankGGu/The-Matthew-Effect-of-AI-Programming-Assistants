#include <stdlib.h>
#include <string.h>

int findJudge(int n, int** trust, int trustSize, int* trustColSize) {
    if (n == 1) {
        return 1;
    }

    int* indegree = (int*)calloc(n + 1, sizeof(int));
    int* outdegree = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i < trustSize; i++) {
        int a = trust[i][0];
        int b = trust[i][1];
        outdegree[a]++;
        indegree[b]++;
    }

    for (int i = 1; i <= n; i++) {
        if (outdegree[i] == 0 && indegree[i] == n - 1) {
            free(indegree);
            free(outdegree);
            return i;
        }
    }

    free(indegree);
    free(outdegree);
    return -1;
}