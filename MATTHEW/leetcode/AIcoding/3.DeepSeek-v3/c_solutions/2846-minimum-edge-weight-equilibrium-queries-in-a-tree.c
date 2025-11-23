/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
#define MAX_N 10000
#define MAX_W 26

typedef struct {
    int node;
    int weight;
} Edge;

Edge graph[MAX_N][50];
int graphSize[MAX_N];

int depth[MAX_N];
int parent[MAX_N][15];
int weightCount[MAX_N][MAX_W+1];
int pathWeight[MAX_N][MAX_W+1];

void dfs(int u, int p, int d, int* weightsFromRoot) {
    depth[u] = d;
    parent[u][0] = p;

    for (int i = 1; i < 15; i++) {
        if (parent[u][i-1] != -1) {
            parent[u][i] = parent[parent[u][i-1]][i-1];
        } else {
            parent[u][i] = -1;
        }
    }

    for (int i = 1; i <= MAX_W; i++) {
        weightCount[u][i] = weightsFromRoot[i];
    }

    for (int i = 0; i < graphSize[u]; i++) {
        int v = graph[u][i].node;
        int w = graph[u][i].weight;
        if (v != p) {
            weightsFromRoot[w]++;
            dfs(v, u, d+1, weightsFromRoot);
            weightsFromRoot[w]--;
        }
    }
}

int lca(int u, int v) {
    if (depth[u] < depth[v]) {
        int temp = u;
        u = v;
        v = temp;
    }

    int diff = depth[u] - depth[v];
    for (int i = 0; i < 15; i++) {
        if (diff & (1 << i)) {
            u = parent[u][i];
        }
    }

    if (u == v) return u;

    for (int i = 14; i >= 0; i--) {
        if (parent[u][i] != parent[v][i]) {
            u = parent[u][i];
            v = parent[v][i];
        }
    }
    return parent[u][0];
}

int* minOperationsQueries(int n, int** edges, int edgesSize, int* edgesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    for (int i = 0; i < n; i++) {
        graphSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        graph[u][graphSize[u]].node = v;
        graph[u][graphSize[u]].weight = w;
        graphSize[u]++;

        graph[v][graphSize[v]].node = u;
        graph[v][graphSize[v]].weight = w;
        graphSize[v]++;
    }

    int weightsFromRoot[MAX_W+1] = {0};
    dfs(0, -1, 0, weightsFromRoot);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        int ancestor = lca(u, v);

        int totalEdges = depth[u] + depth[v] - 2 * depth[ancestor];
        int maxFreq = 0;

        for (int w = 1; w <= MAX_W; w++) {
            int count = weightCount[u][w] + weightCount[v][w] - 2 * weightCount[ancestor][w];
            if (count > maxFreq) {
                maxFreq = count;
            }
        }

        result[i] = totalEdges - maxFreq;
    }

    return result;
}