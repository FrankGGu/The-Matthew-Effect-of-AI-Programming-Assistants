#include <stdbool.h>
#include <string.h>

int parent[26];

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

void union_sets(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        parent[root_i] = root_j;
    }
}

bool equationsPossible(char **equations, int equationsSize) {
    for (int i = 0; i < 26; ++i) {
        parent[i] = i;
    }

    for (int i = 0; i < equationsSize; ++i) {
        if (equations[i][1] == '=') {
            int var1 = equations[i][0] - 'a';
            int var2 = equations[i][3] - 'a';
            union_sets(var1, var2);
        }
    }

    for (int i = 0; i < equationsSize; ++i) {
        if (equations[i][1] == '!') {
            int var1 = equations[i][0] - 'a';
            int var2 = equations[i][3] - 'a';
            if (find(var1) == find(var2)) {
                return false;
            }
        }
    }

    return true;
}