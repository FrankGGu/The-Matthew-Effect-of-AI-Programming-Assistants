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
        parent[rootX] = rootY;
    }
}

bool equationsPossible(char** equations, int equationsSize) {
    int parent[26];
    for (int i = 0; i < 26; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < equationsSize; i++) {
        if (equations[i][1] == '=') {
            unionSets(parent, equations[i][0] - 'a', equations[i][3] - 'a');
        }
    }

    for (int i = 0; i < equationsSize; i++) {
        if (equations[i][1] == '!') {
            if (find(parent, equations[i][0] - 'a') == find(parent, equations[i][3] - 'a')) {
                return false;
            }
        }
    }

    return true;
}