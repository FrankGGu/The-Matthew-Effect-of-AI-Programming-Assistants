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
        parent[rootY] = rootX;
    }
}

int minimumHammingDistance(int* source, int sourceSize, int* target, int targetSize, int** allowedSwaps, int allowedSwapsSize, int* allowedSwapsColSize) {
    int n = sourceSize;
    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < allowedSwapsSize; i++) {
        int a = allowedSwaps[i][0];
        int b = allowedSwaps[i][1];
        unionSets(parent, a, b);
    }

    int* indices = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (find(parent, i) == find(parent, j)) {
                if (source[indices[i]] == target[j] && source[indices[j]] == target[i]) {
                    int temp = indices[i];
                    indices[i] = indices[j];
                    indices[j] = temp;
                }
            }
        }
    }

    int distance = 0;
    for (int i = 0; i < n; i++) {
        if (source[indices[i]] != target[i]) {
            distance++;
        }
    }

    free(parent);
    free(indices);
    return distance;
}