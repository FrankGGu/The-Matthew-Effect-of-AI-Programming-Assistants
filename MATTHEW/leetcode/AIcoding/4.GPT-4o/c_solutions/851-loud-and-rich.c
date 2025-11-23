int* loudAndRich(int** richer, int richerSize, int* richerColSize, int* quiet, int* returnSize) {
    int n = 0;
    for (int i = 0; i < richerSize; i++) {
        if (richer[i][0] + 1 > n) n = richer[i][0] + 1;
        if (richer[i][1] + 1 > n) n = richer[i][1] + 1;
    }

    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) result[i] = i;

    int** graph = (int**)malloc(n * sizeof(int*));
    int* indegree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) graph[i] = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) memset(graph[i], 0, n * sizeof(int));

    for (int i = 0; i < richerSize; i++) {
        graph[richer[i][1]][richer[i][0]] = 1;
        indegree[richer[i][0]]++;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) queue[rear++] = i;
    }

    while (front < rear) {
        int u = queue[front++];
        for (int v = 0; v < n; v++) {
            if (graph[u][v]) {
                indegree[v]--;
                if (quiet[result[v]] > quiet[u]) result[v] = u;
                if (indegree[v] == 0) queue[rear++] = v;
            }
        }
    }

    *returnSize = n;
    return result;
}