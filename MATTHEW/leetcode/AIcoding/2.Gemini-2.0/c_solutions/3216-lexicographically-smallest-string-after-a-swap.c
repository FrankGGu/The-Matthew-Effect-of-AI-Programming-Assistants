#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unionSet(int parent[], int rank[], int i, int j) {
    int rootI = find(parent, i);
    int rootJ = find(parent, j);
    if (rootI != rootJ) {
        if (rank[rootI] < rank[rootJ])
            parent[rootI] = rootJ;
        else if (rank[rootI] > rank[rootJ])
            parent[rootJ] = rootI;
        else {
            parent[rootJ] = rootI;
            rank[rootI]++;
        }
    }
}

char * smallestStringWithSwaps(char * s, int** pairs, int pairsSize, int* pairsColSize){
    int n = strlen(s);
    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < pairsSize; i++) {
        unionSet(parent, rank, pairs[i][0], pairs[i][1]);
    }

    char **components = (char **)malloc(n * sizeof(char *));
    int *componentSizes = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        components[i] = (char *)malloc((n + 1) * sizeof(char));
        components[i][0] = '\0';
        componentSizes[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int root = find(parent, i);
        components[root][componentSizes[root]++] = s[i];
        components[root][componentSizes[root]] = '\0';
    }

    for (int i = 0; i < n; i++) {
        if (componentSizes[i] > 0) {
            qsort(components[i], componentSizes[i], sizeof(char), cmp);
        }
    }

    char *result = (char *)malloc((n + 1) * sizeof(char));
    result[n] = '\0';
    int *indices = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        indices[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int root = find(parent, i);
        result[i] = components[root][indices[root]++];
    }

    free(parent);
    free(rank);
    for(int i = 0; i < n; i++){
        free(components[i]);
    }
    free(components);
    free(componentSizes);
    free(indices);
    return result;
}

int cmp(const void *a, const void *b) {
    return (*(char *)a - *(char *)b);
}