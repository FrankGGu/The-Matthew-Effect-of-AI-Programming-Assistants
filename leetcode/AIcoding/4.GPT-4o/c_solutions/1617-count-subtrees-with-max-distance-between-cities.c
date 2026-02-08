#define MAXN 10001

typedef struct {
    int to, next;
} Edge;

Edge edges[MAXN * 2];
int head[MAXN], edgeCount = 0;
int dist[MAXN], maxDist[MAXN], count[MAXN];
int n;

void addEdge(int u, int v) {
    edges[edgeCount].to = v;
    edges[edgeCount].next = head[u];
    head[u] = edgeCount++;
}

void dfs(int u, int parent) {
    for (int i = head[u]; i != -1; i = edges[i].next) {
        int v = edges[i].to;
        if (v == parent) continue;
        dfs(v, u);
        if (dist[v] + 1 > dist[u]) {
            maxDist[u] = dist[u];
            dist[u] = dist[v] + 1;
        } else if (dist[v] + 1 > maxDist[u]) {
            maxDist[u] = dist[v] + 1;
        }
    }
    if (dist[u] > 0) count[dist[u]]++;
}

int countSubtrees(int n, int** edgesArr, int edgesSize) {
    memset(head, -1, sizeof(head));
    for (int i = 0; i < edgesSize; i++) {
        addEdge(edgesArr[i][0], edgesArr[i][1]);
        addEdge(edgesArr[i][1], edgesArr[i][0]);
    }
    memset(dist, 0, sizeof(dist));
    memset(maxDist, 0, sizeof(maxDist));
    memset(count, 0, sizeof(count));
    dfs(0, -1);
    int result = 0;
    for (int i = 1; i < n; i++) {
        result += count[i];
    }
    return result;
}