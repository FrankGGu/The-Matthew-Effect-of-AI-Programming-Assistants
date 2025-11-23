#define MAX_NODES 100000

int largestPathValue(char* colors, int** edges, int edgesSize, int* edgesColSize) {
    int n = strlen(colors);

    int* indegree = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphSize = (int*)calloc(n, sizeof(int));
    int* graphCapacity = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(10 * sizeof(int));
        graphCapacity[i] = 10;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        if (graphSize[u] >= graphCapacity[u]) {
            graphCapacity[u] *= 2;
            graph[u] = (int*)realloc(graph[u], graphCapacity[u] * sizeof(int));
        }
        graph[u][graphSize[u]++] = v;
        indegree[v]++;
    }

    int** count = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        count[i] = (int*)calloc(26, sizeof(int));
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int visited = 0;
    int answer = 0;

    while (front < rear) {
        int node = queue[front++];
        visited++;

        count[node][colors[node] - 'a']++;

        for (int i = 0; i < 26; i++) {
            if (count[node][i] > answer) {
                answer = count[node][i];
            }
        }

        for (int i = 0; i < graphSize[node]; i++) {
            int neighbor = graph[node][i];

            for (int j = 0; j < 26; j++) {
                if (count[node][j] > count[neighbor][j]) {
                    count[neighbor][j] = count[node][j];
                }
            }

            indegree[neighbor]--;
            if (indegree[neighbor] == 0) {
                queue[rear++] = neighbor;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
        free(count[i]);
    }
    free(graph);
    free(graphSize);
    free(graphCapacity);
    free(indegree);
    free(count);
    free(queue);

    return visited == n ? answer : -1;
}