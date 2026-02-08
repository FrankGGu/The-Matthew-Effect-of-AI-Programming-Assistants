#define MAXN 100001

typedef struct {
    int to;
    int direction; // 0 for original, 1 for reversed
} Edge;

Edge graph[MAXN][MAXN];
int indegree[MAXN];
int outdegree[MAXN];
int n, m;
int res;

void dfs(int node, int parent) {
    for (int i = 0; i < outdegree[node]; i++) {
        Edge e = graph[node][i];
        if (e.to != parent) {
            res += e.direction;
            dfs(e.to, node);
        }
    }
}

int minReorder(int n, int** connections, int connectionsSize, int* connectionsColSize) {
    res = 0;
    for (int i = 0; i < connectionsSize; i++) {
        int u = connections[i][0];
        int v = connections[i][1];
        graph[u][outdegree[u]++] = (Edge){v, 0};
        graph[v][indegree[v]++] = (Edge){u, 1};
    }
    dfs(0, -1);
    return res;
}