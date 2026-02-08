#include <stdbool.h>
#include <string.h>

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int* parent, int x, int y) {
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

char* smallestEquivalentString(char *s1, char *s2, char *baseStr) {
    int parent[26];
    for (int i = 0; i < 26; i++) {
        parent[i] = i;
    }

    for (int i = 0; s1[i] != '\0'; i++) {
        unionSets(parent, s1[i] - 'a', s2[i] - 'a');
    }

    for (int i = 0; i < 26; i++) {
        find(parent, i);
    }

    char* result = (char*)malloc(strlen(baseStr) + 1);
    for (int i = 0; baseStr[i] != '\0'; i++) {
        result[i] = 'a' + parent[baseStr[i] - 'a'];
    }
    result[strlen(baseStr)] = '\0';
    return result;
}