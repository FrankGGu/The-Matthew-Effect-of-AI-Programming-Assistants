#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int* parent, int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int* parent, int* rank, int x, int y) {
    x = find(parent, x);
    y = find(parent, y);

    if (x != y) {
        if (rank[x] < rank[y]) {
            parent[x] = y;
        } else if (rank[x] > rank[y]) {
            parent[y] = x;
        } else {
            parent[y] = x;
            rank[x]++;
        }
    }
}

int* groupStrings(char** words, int wordsSize, int* returnSize) {
    int* parent = (int*)malloc(sizeof(int) * wordsSize);
    int* rank = (int*)malloc(sizeof(int) * wordsSize);
    int* masks = (int*)malloc(sizeof(int) * wordsSize);

    for (int i = 0; i < wordsSize; i++) {
        parent[i] = i;
        rank[i] = 0;
        masks[i] = 0;
        for (int j = 0; words[i][j] != '\0'; j++) {
            masks[i] |= (1 << (words[i][j] - 'a'));
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if ((masks[i] & masks[j]) == masks[i] || (masks[i] & masks[j]) == masks[j] || __builtin_popcount(masks[i] ^ masks[j]) == 1) {
                unite(parent, rank, i, j);
            }
        }
        for (int k = 0; k < 26; k++) {
            int mask = masks[i] ^ (1 << k);
            if (mask != masks[i]) {
                 for(int j = i + 1; j < wordsSize; j++) {
                     if(masks[j] == mask) {
                         unite(parent, rank, i, j);
                     }
                 }
            }
        }
    }

    int groups = 0;
    int maxSize = 0;
    int* groupSizes = (int*)calloc(wordsSize, sizeof(int));

    for (int i = 0; i < wordsSize; i++) {
        int root = find(parent, i);
        if (groupSizes[root] == 0) {
            groups++;
        }
        groupSizes[root]++;
        if (groupSizes[root] > maxSize) {
            maxSize = groupSizes[root];
        }
    }

    free(parent);
    free(rank);
    free(masks);
    free(groupSizes);

    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = groups;
    result[1] = maxSize;
    *returnSize = 2;
    return result;
}