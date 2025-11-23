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

int minimumHammingDistance(int* source, int sourceSize, int* target, int targetSize, int** allowedSwaps, int allowedSwapsSize, int* allowedSwapsColSize){
    int parent[sourceSize];
    int rank[sourceSize];

    for (int i = 0; i < sourceSize; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < allowedSwapsSize; i++) {
        unite(parent, rank, allowedSwaps[i][0], allowedSwaps[i][1]);
    }

    int hammingDistance = 0;
    int* source_counts[sourceSize];
    int* target_counts[sourceSize];

    for(int i=0; i<sourceSize; i++){
        source_counts[i] = (int*)malloc(sizeof(int) * 1001);
        target_counts[i] = (int*)malloc(sizeof(int) * 1001);
        for(int j = 0; j<1001; j++){
            source_counts[i][j] = 0;
            target_counts[i][j] = 0;
        }
    }

    for (int i = 0; i < sourceSize; i++) {
        source_counts[find(parent, i)][source[i]]++;
        target_counts[find(parent, i)][target[i]]++;
    }

    for (int i = 0; i < sourceSize; i++) {
        if (parent[i] == i) {
            for (int j = 0; j <= 1000; j++) {
                int common = (source_counts[i][j] < target_counts[i][j]) ? source_counts[i][j] : target_counts[i][j];
                source_counts[i][j] -= common;
                target_counts[i][j] -= common;
            }
        }
    }

    for (int i = 0; i < sourceSize; i++) {
        if (parent[i] == i) {
            for (int j = 0; j <= 1000; j++) {
                hammingDistance += source_counts[i][j];
            }
        }
    }

    for(int i=0; i<sourceSize; i++){
        free(source_counts[i]);
        free(target_counts[i]);
    }

    return hammingDistance;
}