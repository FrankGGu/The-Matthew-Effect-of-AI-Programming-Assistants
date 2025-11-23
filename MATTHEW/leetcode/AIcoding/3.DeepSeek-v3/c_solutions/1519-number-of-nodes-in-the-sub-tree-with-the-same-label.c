/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countSubTrees(int n, int** edges, int edgesSize, int* edgesColSize, char * labels, int* returnSize) {
    *returnSize = n;
    int* res = malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) res[i] = 0;

    int** graph = malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = malloc(0);
    }
    int* graphSize = calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        graphSize[u]++;
        graph[u] = realloc(graph[u], graphSize[u] * sizeof(int));
        graph[u][graphSize[u] - 1] = v;

        graphSize[v]++;
        graph[v] = realloc(graph[v], graphSize[v] * sizeof(int));
        graph[v][graphSize[v] - 1] = u;
    }

    int* visited = calloc(n, sizeof(int));

    int* dfs(int node, int parent) {
        visited[node] = 1;
        int* count = calloc(26, sizeof(int));
        count[labels[node] - 'a']++;

        for (int i = 0; i < graphSize[node]; i++) {
            int child = graph[node][i];
            if (child == parent) continue;
            int* childCount = dfs(child, node);
            for (int j = 0; j < 26; j++) {
                count[j] += childCount[j];
            }
            free(childCount);
        }

        res[node] = count[labels[node] - 'a'];
        return count;
    }

    dfs(0, -1);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(visited);

    return res;
}