int maximumInvitations(int* favorite, int favoriteSize) {
    int n = favoriteSize;
    int* indegree = (int*)calloc(n, sizeof(int));
    int* depth = (int*)calloc(n, sizeof(int));
    int* visited = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        indegree[favorite[i]]++;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        int v = favorite[u];
        depth[v] = depth[u] + 1;
        if (--indegree[v] == 0) {
            queue[rear++] = v;
        }
    }

    int maxCycle = 0;
    int sumPairs = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0 || visited[i]) continue;

        int cycleLen = 0;
        int cur = i;
        while (!visited[cur]) {
            visited[cur] = 1;
            cur = favorite[cur];
            cycleLen++;
        }

        if (cycleLen == 2) {
            sumPairs += depth[i] + depth[favorite[i]] + 2;
        } else {
            if (cycleLen > maxCycle) maxCycle = cycleLen;
        }
    }

    free(indegree);
    free(depth);
    free(visited);
    free(queue);

    return maxCycle > sumPairs ? maxCycle : sumPairs;
}