int minTime(int n, int** edges, int edgesSize, int* edgesColSize, bool* hasApple, int hasAppleSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = -1;
    }

    for (int i = 0; i < edgesSize; i++) {
        if (parent[edges[i][1]] == -1) {
            parent[edges[i][1]] = edges[i][0];
        } else {
            parent[edges[i][0]] = edges[i][1];
        }
    }

    bool* visited = (bool*)calloc(n, sizeof(bool));
    visited[0] = true;
    int time = 0;

    for (int i = 0; i < n; i++) {
        if (hasApple[i]) {
            int node = i;
            while (!visited[node]) {
                visited[node] = true;
                time += 2;
                node = parent[node];
            }
        }
    }

    free(parent);
    free(visited);
    return time;
}