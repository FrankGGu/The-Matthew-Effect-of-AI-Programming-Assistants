typedef struct {
    int u, v, w;
} Edge;

int cmp(const void* a, const void* b) {
    return ((Edge*)a)->w - ((Edge*)b)->w;
}

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unite(int* parent, int* rank, int x, int y) {
    int rx = find(parent, x);
    int ry = find(parent, y);
    if (rx != ry) {
        if (rank[rx] < rank[ry]) {
            parent[rx] = ry;
        } else if (rank[rx] > rank[ry]) {
            parent[ry] = rx;
        } else {
            parent[ry] = rx;
            rank[rx]++;
        }
    }
}

int minCostConnectPoints(int** points, int pointsSize, int* pointsColSize) {
    int n = pointsSize;
    Edge* edges = (Edge*)malloc(n * n * sizeof(Edge));
    int edgeCount = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
            edges[edgeCount].u = i;
            edges[edgeCount].v = j;
            edges[edgeCount].w = dist;
            edgeCount++;
        }
    }

    qsort(edges, edgeCount, sizeof(Edge), cmp);

    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int cost = 0;
    int edgesUsed = 0;

    for (int i = 0; i < edgeCount && edgesUsed < n - 1; i++) {
        int u = edges[i].u;
        int v = edges[i].v;
        int w = edges[i].w;

        if (find(parent, u) != find(parent, v)) {
            unite(parent, rank, u, v);
            cost += w;
            edgesUsed++;
        }
    }

    free(edges);
    free(parent);
    free(rank);

    return cost;
}