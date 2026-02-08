#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countHighestScoreNodes(int* parents, int parentsSize) {
    int n = parentsSize;
    int** children = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        children[i] = (int*)malloc(2 * sizeof(int));
        children[i][0] = -1;
        children[i][1] = -1;
    }

    for (int i = 0; i < n; i++) {
        if (parents[i] != -1) {
            if (children[parents[i]][0] == -1) {
                children[parents[i]][0] = i;
            } else {
                children[parents[i]][1] = i;
            }
        }
    }

    long long maxScore = 0;
    int count = 0;

    long long* nodeSizes = (long long*)malloc(n * sizeof(long long));

    function(int, int**, long long*);
    int dfs(int node, int** children, long long* nodeSizes) {
        int size = 1;
        if (children[node][0] != -1) {
            size += dfs(children[node][0], children, nodeSizes);
        }
        if (children[node][1] != -1) {
            size += dfs(children[node][1], children, nodeSizes);
        }
        nodeSizes[node] = size;
        return size;
    }

    dfs(0, children, nodeSizes);

    for (int i = 0; i < n; i++) {
        long long score = 1;
        int parent = parents[i];
        if (children[i][0] != -1) {
            score *= nodeSizes[children[i][0]];
        }
        if (children[i][1] != -1) {
            score *= nodeSizes[children[i][1]];
        }
        if (parent != -1) {
            score *= (n - nodeSizes[i]);
        }

        if (score > maxScore) {
            maxScore = score;
            count = 1;
        } else if (score == maxScore) {
            count++;
        }
    }

    for (int i = 0; i < n; i++) {
        free(children[i]);
    }
    free(children);
    free(nodeSizes);

    return count;
}