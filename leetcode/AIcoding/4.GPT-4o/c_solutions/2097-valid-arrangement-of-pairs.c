#define MAXN 100001

typedef struct {
    int u, v;
} Edge;

typedef struct {
    Edge edges[MAXN];
    int head[MAXN];
    int next[MAXN];
    int indegree[MAXN];
    int outdegree[MAXN];
    int idx;
} Graph;

void initGraph(Graph* g) {
    g->idx = 0;
    memset(g->head, -1, sizeof(g->head));
    memset(g->indegree, 0, sizeof(g->indegree));
    memset(g->outdegree, 0, sizeof(g->outdegree));
}

void addEdge(Graph* g, int u, int v) {
    g->edges[g->idx].u = u;
    g->edges[g->idx].v = v;
    g->next[g->idx] = g->head[u];
    g->head[u] = g->idx;
    g->indegree[v]++;
    g->outdegree[u]++;
    g->idx++;
}

void dfs(Graph* g, int u, int* result, int* returnSize) {
    while (g->head[u] != -1) {
        int idx = g->head[u];
        g->head[u] = g->next[idx];
        dfs(g, g->edges[idx].v, result, returnSize);
    }
    result[(*returnSize)++] = u;
}

int** validArrangement(int** pairs, int pairsSize, int* pairsColSize, int* returnSize) {
    Graph g;
    initGraph(&g);
    for (int i = 0; i < pairsSize; i++) {
        addEdge(&g, pairs[i][0], pairs[i][1]);
    }

    int start = -1, end = -1;
    for (int i = 0; i < MAXN; i++) {
        if (g.outdegree[i] > g.indegree[i]) {
            start = i;
        } else if (g.indegree[i] > g.outdegree[i]) {
            end = i;
        }
    }
    if (start == -1) start = pairs[0][0];

    int* result = (int*)malloc((pairsSize + 1) * sizeof(int));
    int resultSize = 0;
    dfs(&g, start, result, &resultSize);

    int** ans = (int**)malloc(pairsSize * sizeof(int*));
    for (int i = 0; i < pairsSize; i++) {
        ans[i] = (int*)malloc(2 * sizeof(int));
    }
    for (int i = 0; i < pairsSize; i++) {
        ans[i][0] = result[resultSize - 1 - i];
        ans[i][1] = result[resultSize - 2 - i];
    }

    *returnSize = pairsSize;
    free(result);
    return ans;
}