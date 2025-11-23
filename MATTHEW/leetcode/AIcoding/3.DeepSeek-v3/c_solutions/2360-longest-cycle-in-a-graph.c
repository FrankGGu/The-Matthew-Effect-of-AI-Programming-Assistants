int longestCycle(int* edges, int edgesSize) {
    int n = edgesSize;
    int* visited = (int*)calloc(n, sizeof(int));
    int* dist = (int*)calloc(n, sizeof(int));
    int maxCycle = -1;
    int time = 1;

    for (int i = 0; i < n; i++) {
        if (visited[i]) continue;

        int start = time;
        int node = i;

        while (node != -1 && !visited[node]) {
            visited[node] = time;
            dist[node] = time - start;
            time++;
            node = edges[node];
        }

        if (node != -1 && visited[node] >= start) {
            int cycleLength = (time - start) - dist[node];
            if (cycleLength > maxCycle) {
                maxCycle = cycleLength;
            }
        }
    }

    free(visited);
    free(dist);
    return maxCycle;
}