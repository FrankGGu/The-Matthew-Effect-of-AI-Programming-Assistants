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
        if (rank[xroot] < rank[yroot])
            parent[xroot] = yroot;
        else if (rank[xroot] > rank[yroot])
            parent[yroot] = xroot;
        else {
            parent[yroot] = xroot;
            rank[xroot]++;
        }
    }
}

bool* friendRequests(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize, int** requests, int requestsSize, int* requestsColSize, int* returnSize) {
    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    bool* result = (bool*)malloc(requestsSize * sizeof(bool));
    *returnSize = requestsSize;

    for (int i = 0; i < requestsSize; i++) {
        int u = requests[i][0];
        int v = requests[i][1];

        int uRoot = find(parent, u);
        int vRoot = find(parent, v);

        bool safe = true;
        for (int j = 0; j < restrictionsSize; j++) {
            int x = restrictions[j][0];
            int y = restrictions[j][1];

            int xRoot = find(parent, x);
            int yRoot = find(parent, y);

            if ((xRoot == uRoot && yRoot == vRoot) || (xRoot == vRoot && yRoot == uRoot)) {
                safe = false;
                break;
            }
        }

        if (safe) {
            unite(parent, rank, u, v);
            result[i] = true;
        } else {
            result[i] = false;
        }
    }

    return result;
}