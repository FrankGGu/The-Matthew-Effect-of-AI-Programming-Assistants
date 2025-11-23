#define MAXN 100

typedef struct {
    int u, v;
} Edge;

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        parent[rootY] = rootX;
    }
}

bool canFinish(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize) {
    int* parent = (int*)malloc(numCourses * sizeof(int));
    for (int i = 0; i < numCourses; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][1];
        int v = prerequisites[i][0];
        if (find(parent, u) == find(parent, v)) {
            free(parent);
            return false;
        }
        unionSet(parent, u, v);
    }

    free(parent);
    return true;
}

bool checkIfPrerequisite(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int** queries, int queriesSize, bool* returnSize) {
    int* parent = (int*)malloc(numCourses * sizeof(int));
    for (int i = 0; i < numCourses; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        unionSet(parent, prerequisites[i][1], prerequisites[i][0]);
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = find(parent, queries[i][0]) == find(parent, queries[i][1]);
    }

    free(parent);
    *returnSize = queriesSize;
    return result;
}