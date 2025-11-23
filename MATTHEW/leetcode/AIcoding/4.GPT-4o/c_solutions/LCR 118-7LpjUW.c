int* findRedundantDirectedConnection(int** edges, int edgesSize, int* edgesColSize){
    int* parent = (int*)malloc((edgesSize + 1) * sizeof(int));
    for (int i = 0; i <= edgesSize; ++i) parent[i] = i;

    int conflictEdge[2] = {-1, -1};
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0], v = edges[i][1];
        if (parent[v] != v) {
            conflictEdge[0] = u;
            conflictEdge[1] = v;
            continue;
        }
        parent[v] = u;
    }

    int* result = (int*)malloc(2 * sizeof(int));
    if (conflictEdge[0] == -1) return NULL;

    for (int i = edgesSize - 1; i >= 0; --i) {
        int u = edges[i][0], v = edges[i][1];
        if (u == conflictEdge[0] && v == conflictEdge[1]) {
            result[0] = u;
            result[1] = v;
            break;
        }
        if (parent[v] != v) {
            parent[v] = u;
            result[0] = parent[v];
            result[1] = v;
            break;
        }
    }

    return result;
}