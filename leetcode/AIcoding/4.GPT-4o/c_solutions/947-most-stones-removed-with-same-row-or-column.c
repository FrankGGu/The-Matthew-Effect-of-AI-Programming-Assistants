int find(int x, int* parent) {
    if (parent[x] != x) {
        parent[x] = find(parent[x], parent);
    }
    return parent[x];
}

void unionSet(int x, int y, int* parent) {
    int rootX = find(x, parent);
    int rootY = find(y, parent);
    if (rootX != rootY) {
        parent[rootY] = rootX;
    }
}

int removeStones(int** stones, int stonesSize, int* stonesColSize) {
    int* parent = (int*)malloc(20000 * sizeof(int));
    for (int i = 0; i < 20000; i++) parent[i] = i;

    for (int i = 0; i < stonesSize; i++) {
        unionSet(stones[i][0], stones[i][1] + 10000, parent);
    }

    int count = 0;
    for (int i = 0; i < stonesSize; i++) {
        if (find(stones[i][0], parent) == stones[i][0]) {
            count++;
        }
    }

    free(parent);
    return stonesSize - count;
}