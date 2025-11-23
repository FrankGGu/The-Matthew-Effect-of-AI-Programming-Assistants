#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool sequenceReconstruction(int* org, int orgSize, int** seqs, int seqsSize, int* seqsColSize) {
    if (orgSize == 0) {
        return seqsSize == 0;
    }

    int n = orgSize;
    int* inDegree = (int*)calloc(n + 1, sizeof(int));
    int** adj = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        adj[i] = (int*)calloc(n + 1, sizeof(int));
    }

    int edges = 0;

    for (int i = 0; i < seqsSize; i++) {
        for (int j = 0; j < seqsColSize[i] - 1; j++) {
            if (seqs[i][j] <= 0 || seqs[i][j] > n || seqs[i][j + 1] <= 0 || seqs[i][j + 1] > n) {
                return false;
            }
            if (adj[seqs[i][j]][seqs[i][j + 1]] == 0) {
                adj[seqs[i][j]][seqs[i][j + 1]] = 1;
                inDegree[seqs[i][j + 1]]++;
                edges++;
            }
        }
    }

    int* queue = (int*)malloc((n + 1) * sizeof(int));
    int head = 0, tail = 0;

    for (int i = 1; i <= n; i++) {
        if (inDegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    int reconstructedSize = 0;
    while (head < tail) {
        if (tail - head > 1) {
            free(inDegree);
            for (int i = 0; i <= n; i++) {
                free(adj[i]);
            }
            free(adj);
            free(queue);
            return false;
        }

        int u = queue[head++];
        if (reconstructedSize >= orgSize || org[reconstructedSize] != u) {
            free(inDegree);
            for (int i = 0; i <= n; i++) {
                free(adj[i]);
            }
            free(adj);
            free(queue);
            return false;
        }
        reconstructedSize++;

        for (int v = 1; v <= n; v++) {
            if (adj[u][v] == 1) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue[tail++] = v;
                }
            }
        }
    }

    free(inDegree);
    for (int i = 0; i <= n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(queue);
    return reconstructedSize == orgSize && edges == (orgSize - 1);
}