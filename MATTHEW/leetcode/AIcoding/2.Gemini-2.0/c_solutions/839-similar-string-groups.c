#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int areSimilar(char *s1, char *s2) {
    int diff = 0;
    int first = -1, second = -1;
    for (int i = 0; s1[i] != '\0'; i++) {
        if (s1[i] != s2[i]) {
            diff++;
            if (first == -1) {
                first = i;
            } else if (second == -1) {
                second = i;
            }
        }
    }
    if (diff == 0) return 1;
    if (diff == 2 && s1[first] == s2[second] && s1[second] == s2[first]) return 1;
    return 0;
}

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

int numSimilarGroups(char **strs, int strsSize) {
    int parent[strsSize];
    int rank[strsSize];

    for (int i = 0; i < strsSize; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int count = strsSize;
    for (int i = 0; i < strsSize; i++) {
        for (int j = i + 1; j < strsSize; j++) {
            if (areSimilar(strs[i], strs[j])) {
                int rootI = find(parent, i);
                int rootJ = find(parent, j);
                if (rootI != rootJ) {
                    unite(parent, rank, i, j);
                    count--;
                }
            }
        }
    }

    return count;
}