int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int x, int y) {
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
            int x = equations[i][0] - 'a';
            int y = equations[i][3] - 'a';
            unionSet(parent, x, y);
        }
    }

    for (int i = 0; i < equationsSize; i++) {
        if (equations[i][1] == '!') {
            int x = equations[i][0] - 'a';
            int y = equations[i][3] - 'a';
            if (find(parent, x) == find(parent, y)) {
                return false;
            }
        }
    }

    return true;
}