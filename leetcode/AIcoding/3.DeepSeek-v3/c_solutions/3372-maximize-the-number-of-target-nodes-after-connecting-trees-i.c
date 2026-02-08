/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maximumTargetNodes(int** edges1, int edges1Size, int* edges1ColSize, int** edges2, int edges2Size, int* edges2ColSize, int* returnSize) {
    int n = edges1Size + 1;
    int m = edges2Size + 1;

    // Build adjacency lists for both trees
    int* adj1[n];
    int adj1Size[n];
    int* adj2[m];
    int adj2Size[m];

    for (int i = 0; i < n; i++) {
        adj1[i] = (int*)malloc(n * sizeof(int));
        adj1Size[i] = 0;
    }
    for (int i = 0; i < m; i++) {
        adj2[i] = (int*)malloc(m * sizeof(int));
        adj2Size[i] = 0;
    }

    for (int i = 0; i < edges1Size; i++) {
        int u = edges1[i][0];
        int v = edges1[i][1];
        adj1[u][adj1Size[u]++] = v;
        adj1[v][adj1Size[v]++] = u;
    }

    for (int i = 0; i < edges2Size; i++) {
        int u = edges2[i][0];
        int v = edges2[i][1];
        adj2[u][adj2Size[u]++] = v;
        adj2[v][adj2Size[v]++] = u;
    }

    // Calculate depths for tree1
    int depth1[n];
    int maxDepth1 = 0;
    int deepest1 = 0;

    void dfs1(int node, int parent, int depth) {
        depth1[node] = depth;
        if (depth > maxDepth1) {
            maxDepth1 = depth;
            deepest1 = node;
        }
        for (int i = 0; i < adj1Size[node]; i++) {
            int neighbor = adj1[node][i];
            if (neighbor != parent) {
                dfs1(neighbor, node, depth + 1);
            }
        }
    }

    dfs1(0, -1, 0);
    maxDepth1 = 0;
    dfs1(deepest1, -1, 0);

    // Calculate depths for tree2
    int depth2[m];
    int maxDepth2 = 0;
    int deepest2 = 0;

    void dfs2(int node, int parent, int depth) {
        depth2[node] = depth;
        if (depth > maxDepth2) {
            maxDepth2 = depth;
            deepest2 = node;
        }
        for (int i = 0; i < adj2Size[node]; i++) {
            int neighbor = adj2[node][i];
            if (neighbor != parent) {
                dfs2(neighbor, node, depth + 1);
            }
        }
    }

    dfs2(0, -1, 0);
    maxDepth2 = 0;
    dfs2(deepest2, -1, 0);

    // Find the best connection
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    // Try connecting the deepest nodes from both trees
    result[0] = deepest1;
    result[1] = deepest2;

    // Clean up
    for (int i = 0; i < n; i++) {
        free(adj1[i]);
    }
    for (int i = 0; i < m; i++) {
        free(adj2[i]);
    }

    return result;
}