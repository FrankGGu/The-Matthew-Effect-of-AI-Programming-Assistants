int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unite(int* parent, int* rank, int x, int y) {
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

int cmp(const void* a, const void* b) {
    int* edgeA = *(int**)a;
    int* edgeB = *(int**)b;
    return edgeA[2] - edgeB[2];
}

int minMaxWeight(int n, int** edges, int edgesSize, int* edgesColSize, int threshold) {
    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    qsort(edges, edgesSize, sizeof(int*), cmp);

    int components = n;
    int maxWeight = 0;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        if (find(parent, u) != find(parent, v)) {
            unite(parent, rank, u, v);
            components--;
            maxWeight = w > maxWeight ? w : maxWeight;
        }

        if (components == threshold) {
            break;
        }
    }

    return maxWeight;
}