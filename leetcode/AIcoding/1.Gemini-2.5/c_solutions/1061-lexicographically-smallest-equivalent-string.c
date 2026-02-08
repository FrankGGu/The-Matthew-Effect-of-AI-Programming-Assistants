#include <stdlib.h>
#include <string.h>

int parent[26];

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int rootI = find(i);
    int rootJ = find(j);

    if (rootI != rootJ) {
        if (rootI < rootJ) {
            parent[rootJ] = rootI;
        } else {
            parent[rootI] = rootJ;
        }
    }
}

char* smallestEquivalentString(char* s1, char* s2, char* baseStr) {
    for (int i = 0; i < 26; i++) {
        parent[i] = i;
    }

    int len = strlen(s1);
    for (int i = 0; i < len; i++) {
        unite(s1[i] - 'a', s2[i] - 'a');
    }

    int baseStrLen = strlen(baseStr);
    char* result = (char*)malloc((baseStrLen + 1) * sizeof(char));

    for (int i = 0; i < baseStrLen; i++) {
        result[i] = (char)('a' + find(baseStr[i] - 'a'));
    }
    result[baseStrLen] = '\0';

    return result;
}