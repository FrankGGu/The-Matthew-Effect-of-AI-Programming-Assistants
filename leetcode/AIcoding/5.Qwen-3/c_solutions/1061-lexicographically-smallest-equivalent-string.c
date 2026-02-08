#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int *parent, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rootX < rootY) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
        }
    }
}

char* smallestEquivalentChar(char c) {
    return (char[]){c};
}

char* smallestEquivalentString(char* A, char* B, char* S) {
    int len = strlen(S);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int parent[26];
    for (int i = 0; i < 26; i++) {
        parent[i] = i;
    }
    for (int i = 0; i < strlen(A); i++) {
        int a = A[i] - 'a';
        int b = B[i] - 'a';
        unionSet(parent, a, b);
    }
    for (int i = 0; i < len; i++) {
        int index = S[i] - 'a';
        int root = find(parent, index);
        result[i] = (char)('a' + root);
    }
    result[len] = '\0';
    return result;
}