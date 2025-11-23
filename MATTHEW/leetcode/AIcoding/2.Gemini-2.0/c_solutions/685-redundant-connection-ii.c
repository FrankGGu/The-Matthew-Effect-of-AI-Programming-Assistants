#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    int xroot = find(parent, x);
    int yroot = find(parent, y);

    if (xroot != yroot) {
        if (rank[xroot] < rank[yroot]) {
            parent[xroot] = yroot;
        } else if (rank[xroot] > rank[yroot]) {
            parent[yroot] = xroot;
        } else {
            parent[yroot] = xroot;
            rank[xroot]++;
        }
    }
}

int* findRedundantDirectedConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = edgesSize;
    int* parent = (int*)malloc((n + 1) * sizeof(int));
    int* rank = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int inDegree[n + 1];
    for (int i = 1; i <= n; i++) {
        inDegree[i] = 0;
    }

    int firstCandidate = -1;
    int secondCandidate = -1;

    for (int i = 0; i < edgesSize; i++) {
        inDegree[edges[i][1]]++;
        if (inDegree[edges[i][1]] == 2) {
            if (firstCandidate == -1) {
                firstCandidate = i;
            } else {
                secondCandidate = i;
            }
        }
    }

    if (firstCandidate != -1) {
        if (secondCandidate != -1) {
            *returnSize = 2;
            int* ans = (int*)malloc(2 * sizeof(int));
            ans[0] = edges[secondCandidate][0];
            ans[1] = edges[secondCandidate][1];
            return ans;
        }
        *returnSize = 2;
        int* ans = (int*)malloc(2 * sizeof(int));
        ans[0] = edges[firstCandidate][0];
        ans[1] = edges[firstCandidate][1];
        return ans;
    }

    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int* cycleEdge = NULL;
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        int pu = find(parent, u);
        int pv = find(parent, v);

        if (pu == pv) {
            *returnSize = 2;
            cycleEdge = (int*)malloc(2 * sizeof(int));
            cycleEdge[0] = u;
            cycleEdge[1] = v;
            break;
        } else {
            unite(parent, rank, u, v);
        }
    }

    return cycleEdge;
}