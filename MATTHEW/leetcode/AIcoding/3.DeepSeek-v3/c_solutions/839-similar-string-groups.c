int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

bool isSimilar(char* a, char* b) {
    int len = strlen(a);
    int diff = 0;
    for (int i = 0; i < len; i++) {
        if (a[i] != b[i]) {
            diff++;
            if (diff > 2) return false;
        }
    }
    return diff == 0 || diff == 2;
}

int numSimilarGroups(char** strs, int strsSize) {
    int n = strsSize;
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (isSimilar(strs[i], strs[j])) {
                unionSets(parent, rank, i, j);
            }
        }
    }

    int groups = 0;
    for (int i = 0; i < n; i++) {
        if (parent[i] == i) {
            groups++;
        }
    }

    free(parent);
    free(rank);
    return groups;
}