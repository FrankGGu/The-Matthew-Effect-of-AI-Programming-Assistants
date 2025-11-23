#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unionSet(int parent[], int rank[], int a, int b) {
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

int countConnectedComponents(int n, int edges[][2], int edgesSize) {
    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSet(parent, rank, edges[i][0], edges[i][1]);
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (parent[i] == i)
            count++;
    }

    free(parent);
    free(rank);
    return count;
}

int gcd(int a, int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

int lcm(int a, int b) {
    return (a * b) / gcd(a, b);
}

int countComponents(int n) {
    int *parent = (int *)malloc((n + 1) * sizeof(int));
    int *rank = (int *)malloc((n + 1) * sizeof(int));

    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            if (lcm(i, j) <= n) {
                unionSet(parent, rank, i, j);
            }
        }
    }

    int count = 0;
    for (int i = 1; i <= n; i++) {
        if (parent[i] == i)
            count++;
    }

    free(parent);
    free(rank);
    return count;
}