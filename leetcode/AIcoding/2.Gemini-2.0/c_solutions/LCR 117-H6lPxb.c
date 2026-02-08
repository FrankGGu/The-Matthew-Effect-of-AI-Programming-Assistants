#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int areSimilar(char *s1, char *s2) {
    int diffCount = 0;
    int firstDiff = -1;
    int secondDiff = -1;
    int len = strlen(s1);
    for (int i = 0; i < len; i++) {
        if (s1[i] != s2[i]) {
            diffCount++;
            if (diffCount == 1) {
                firstDiff = i;
            } else if (diffCount == 2) {
                secondDiff = i;
            } else {
                return 0;
            }
        }
    }
    if (diffCount == 0) {
        return 1;
    }
    if (diffCount == 2) {
        return (s1[firstDiff] == s2[secondDiff] && s1[secondDiff] == s2[firstDiff]);
    }
    return 0;
}

int find(int *parent, int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent, parent[i]);
}

void unionSet(int *parent, int i, int j) {
    int rootI = find(parent, i);
    int rootJ = find(parent, j);
    parent[rootI] = rootJ;
}

int numSimilarGroups(char **strs, int strsSize) {
    int *parent = (int *)malloc(strsSize * sizeof(int));
    for (int i = 0; i < strsSize; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < strsSize; i++) {
        for (int j = i + 1; j < strsSize; j++) {
            if (areSimilar(strs[i], strs[j])) {
                unionSet(parent, i, j);
            }
        }
    }

    int count = 0;
    for (int i = 0; i < strsSize; i++) {
        if (parent[i] == i) {
            count++;
        }
    }

    free(parent);
    return count;
}