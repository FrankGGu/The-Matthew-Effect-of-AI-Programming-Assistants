/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int* rank, int x, int y) {
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

bool* areConnected(int n, int threshold, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* parent = (int*)malloc((n + 1) * sizeof(int));
    int* rank = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int z = threshold + 1; z <= n; z++) {
        for (int multiple = z * 2; multiple <= n; multiple += z) {
            unionSet(parent, rank, z, multiple);
        }
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int b = queries[i][1];
        result[i] = (find(parent, a) == find(parent, b));
    }

    free(parent);
    free(rank);
    return result;
}