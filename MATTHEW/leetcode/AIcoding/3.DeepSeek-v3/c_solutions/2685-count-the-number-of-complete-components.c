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

int countCompleteComponents(int n, int** edges, int edgesSize, int* edgesColSize) {
    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSets(parent, rank, edges[i][0], edges[i][1]);
    }

    int nodeCount[n];
    int edgeCount[n];
    for (int i = 0; i < n; i++) {
        nodeCount[i] = 0;
        edgeCount[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int root = find(parent, i);
        nodeCount[root]++;
    }

    for (int i = 0; i < edgesSize; i++) {
        int root = find(parent, edges[i][0]);
        edgeCount[root]++;
    }

    int completeCount = 0;
    for (int i = 0; i < n; i++) {
        if (nodeCount[i] > 0) {
            int nodes = nodeCount[i];
            int expectedEdges = nodes * (nodes - 1) / 2;
            if (edgeCount[i] == expectedEdges) {
                completeCount++;
            }
        }
    }

    return completeCount;
}