#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);

    if (rootX != rootY) {
        if (rootX < rootY)
            parent[rootY] = rootX;
        else
            parent[rootX] = rootY;
    }
}

char * smallestEquivalentString(char * s1, char * s2, char * baseStr){
    int n = strlen(s1);
    int m = strlen(baseStr);
    int parent[26];
    int rank[26];

    for (int i = 0; i < 26; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        unite(parent, rank, s1[i] - 'a', s2[i] - 'a');
    }

    char * result = (char *)malloc(sizeof(char) * (m + 1));
    for (int i = 0; i < m; i++) {
        result[i] = find(parent, baseStr[i] - 'a') + 'a';
    }
    result[m] = '\0';

    return result;
}