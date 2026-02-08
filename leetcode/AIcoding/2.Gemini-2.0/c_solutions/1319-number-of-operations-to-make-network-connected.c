#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unionSets(int parent[], int rank[], int a, int b) {
    a = find(parent, a);
    b = find(parent, b);
    if (a != b) {
        if (rank[a] < rank[b])
            parent[a] = b;
        else if (rank[a] > rank[b])
            parent[b] = a;
        else {
            parent[b] = a;
            rank[a]++;
        }
    }
}

int makeConnected(int n, int** connections, int connectionsSize, int* connectionsColSize){
    if (connectionsSize < n - 1)
        return -1;

    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < connectionsSize; i++) {
        unionSets(parent, rank, connections[i][0], connections[i][1]);
    }

    int components = 0;
    for (int i = 0; i < n; i++) {
        if (parent[i] == i)
            components++;
    }

    return components - 1;
}