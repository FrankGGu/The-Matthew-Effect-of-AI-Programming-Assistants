#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int x, int *parent) {
    if (parent[x] != x) {
        parent[x] = find(parent[x], parent);
    }
    return parent[x];
}

void unionSet(int x, int y, int *parent, int *rank) {
    int rootX = find(x, parent);
    int rootY = find(y, parent);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
            if (rank[rootX] == rank[rootY]) {
                rank[rootY]++;
            }
        }
    }
}

bool equationsPossible(char **equations, int equationsSize) {
    int parent[26];
    int rank[26];
    for (int i = 0; i < 26; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < equationsSize; i++) {
        if (equations[i][1] == '=') {
            int x = equations[i][0] - 'a';
            int y = equations[i][3] - 'a';
            unionSet(x, y, parent, rank);
        }
    }

    for (int i = 0; i < equationsSize; i++) {
        if (equations[i][1] == '!') {
            int x = equations[i][0] - 'a';
            int y = equations[i][3] - 'a';
            if (find(x, parent) == find(y, parent)) {
                return false;
            }
        }
    }

    return true;
}