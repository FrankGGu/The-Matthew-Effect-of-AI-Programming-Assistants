typedef struct {
    int x, y;
} Point;

typedef struct {
    Point *points;
    int size;
    int capacity;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind *uf = (UnionFind *)malloc(sizeof(UnionFind));
    uf->points = (Point *)malloc(n * sizeof(Point));
    uf->size = n;
    uf->capacity = n;
    for (int i = 0; i < n; i++) {
        uf->points[i].x = i;
        uf->points[i].y = 1;
    }
    return uf;
}

int find(UnionFind *uf, int index) {
    if (uf->points[index].x != index) {
        uf->points[index].x = find(uf, uf->points[index].x);
    }
    return uf->points[index].x;
}

void unionSets(UnionFind *uf, int a, int b) {
    int rootA = find(uf, a);
    int rootB = find(uf, b);
    if (rootA != rootB) {
        uf->points[rootB].x = rootA;
    }
}

bool canPathExist(int n, int** edges, int edgesSize, int* edgesColSize, int* queries, int queriesSize, int** queryEdges, int queryEdgesSize) {
    UnionFind *uf = createUnionFind(n);

    for (int i = 0; i < edgesSize; i++) {
        unionSets(uf, edges[i][0], edges[i][1]);
    }

    bool *result = (bool *)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = find(uf, queries[i][0]) == find(uf, queries[i][1]);
    }

    free(uf->points);
    free(uf);
    return result;
}

bool* pathExistenceQueries(int n, int** edges, int edgesSize, int* edgesColSize, int** queries, int queriesSize, int* returnSize) {
    bool *result = canPathExist(n, edges, edgesSize, edgesColSize, queries, queriesSize, NULL, 0);
    *returnSize = queriesSize;
    return result;
}