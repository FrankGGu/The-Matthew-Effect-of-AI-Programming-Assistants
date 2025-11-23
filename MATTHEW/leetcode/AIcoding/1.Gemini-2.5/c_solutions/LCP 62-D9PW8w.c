int trafficHub(int** graph, int graphSize, int* graphColSize) {
    int n = graphSize;

    if (n == 0) {
        return -1;
    }
    if (n == 1) {
        return 0;
    }

    int candidate = 0;

    for (int i = 1; i < n; i++) {
        if (graph[candidate][i] == 1) {
            candidate = i;
        }
    }

    for (int i = 0; i < n; i++) {
        if (i == candidate) {
            continue;
        }
        if (graph[candidate][i] == 1) {
            return -1;
        }
        if (graph[i][candidate] == 0) {
            return -1;
        }
    }

    return candidate;
}