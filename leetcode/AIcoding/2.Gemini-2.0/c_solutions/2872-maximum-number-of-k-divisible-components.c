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

    if (xroot == yroot)
        return;

    if (rank[xroot] < rank[yroot])
        parent[xroot] = yroot;
    else if (rank[xroot] > rank[yroot])
        parent[yroot] = xroot;
    else {
        parent[yroot] = xroot;
        rank[xroot]++;
    }
}

int maxKDivisibleComponents(int n, int edges[][2], int edgesSize, int edgesColSize, int k, int values[]) {
    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        unite(parent, rank, edges[i][0], edges[i][1]);
    }

    int components[n];
    for (int i = 0; i < n; i++) {
        components[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        components[find(parent, i)] += values[i];
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (components[i] % k == 0 && components[i] != 0) {
            count++;
        }
    }

    return count;
}