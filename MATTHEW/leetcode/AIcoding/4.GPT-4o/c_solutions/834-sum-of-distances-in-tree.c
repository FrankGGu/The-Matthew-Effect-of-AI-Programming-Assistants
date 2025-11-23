#define MAXN 10000

int count[MAXN], res[MAXN];
int totalNodes;

void dfs1(int node, int parent, int* graph[], int* dist) {
    count[node] = 1;
    for (int i = 0; i < dist[node]; i++) {
        int next = graph[node][i];
        if (next != parent) {
            dfs1(next, node, graph, dist);
            count[node] += count[next];
            res[node] += res[next] + count[next];
        }
    }
}

void dfs2(int node, int parent, int* graph[], int* dist) {
    for (int i = 0; i < dist[node]; i++) {
        int next = graph[node][i];
        if (next != parent) {
            res[next] = res[node] - count[next] + totalNodes - count[next];
            dfs2(next, node, graph, dist);
        }
    }
}

int* sumOfDistancesInTree(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* graph[MAXN] = {0};
    totalNodes = n;
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][dist[edges[i][0]]++] = edges[i][1];
        graph[edges[i][1]][dist[edges[i][1]]++] = edges[i][0];
    }

    dfs1(0, -1, graph, dist);
    dfs2(0, -1, graph, dist);

    *returnSize = n;
    return res;
}