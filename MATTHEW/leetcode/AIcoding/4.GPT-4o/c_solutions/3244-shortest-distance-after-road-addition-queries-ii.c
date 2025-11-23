#define MAXN 100001
#define MAXM 200001

typedef struct {
    int x, y, w;
} Edge;

int parent[MAXN];
int rank[MAXN];

int find(int x) {
    if (parent[x] != x) {
        parent[x] = find(parent[x]);
    }
    return parent[x];
}

void unionSet(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int* shortestDistance(int n, int** roads, int roadsSize, int* roadsColSize, int** queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    Edge edges[MAXM];
    int edgeCount = 0;

    for (int i = 0; i < roadsSize; i++) {
        edges[edgeCount++] = (Edge){roads[i][0], roads[i][1], 1};
    }

    for (int i = 0; i < queriesSize; i++) {
        edges[edgeCount++] = (Edge){queries[i][0], queries[i][1], 0};
    }

    qsort(edges, edgeCount, sizeof(Edge), [](const void* a, const void* b) {
        return ((Edge*)a)->w - ((Edge*)b)->w;
    });

    for (int i = 0; i < edgeCount; i++) {
        int u = edges[i].x;
        int v = edges[i].y;
        unionSet(u, v);

        if (edges[i].w == 0) {
            int dist = 0;
            for (int j = 0; j < queriesSize; j++) {
                if (find(queries[j][0]) == find(queries[j][1])) {
                    dist = 1;
                    break;
                }
            }
            result[i - roadsSize] = dist == 0 ? -1 : 1;
        }
    }

    return result;
}