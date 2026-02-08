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

long long countPairs(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSets(parent, rank, edges[i][0], edges[i][1]);
    }

    int* componentSize = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        int root = find(parent, i);
        componentSize[root]++;
    }

    long long totalPairs = 0;
    long long sum = 0;
    for (int i = 0; i < n; i++) {
        if (componentSize[i] > 0) {
            totalPairs += sum * componentSize[i];
            sum += componentSize[i];
        }
    }

    free(parent);
    free(rank);
    free(componentSize);

    return totalPairs;
}