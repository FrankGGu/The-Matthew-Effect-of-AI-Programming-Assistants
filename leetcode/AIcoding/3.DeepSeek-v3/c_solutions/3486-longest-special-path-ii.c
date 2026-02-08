typedef struct {
    int node;
    int parent;
    int depth;
    int start;
} State;

int longestSpecialPath(int** edges, int edgesSize, int* edgesColSize, int* nums, int numsSize) {
    int n = numsSize;
    if (n == 0) return 0;

    int* degree = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(0);
    }
    int* graphSize = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;

        graph[u] = (int*)realloc(graph[u], (graphSize[u] + 1) * sizeof(int));
        graph[v] = (int*)realloc(graph[v], (graphSize[v] + 1) * sizeof(int));
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        if (degree[i] == 1) {
            queue[rear++] = i;
        }
    }

    int* newDegree = (int*)malloc(n * sizeof(int));
    memcpy(newDegree, degree, n * sizeof(int));

    while (front < rear) {
        int u = queue[front++];
        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            if (--newDegree[v] == 1) {
                queue[rear++] = v;
            }
        }
    }

    int maxLen = 1;

    State* stack = (State*)malloc(n * sizeof(State));

    for (int start = 0; start < n; start++) {
        if (newDegree[start] != 1) continue;

        int top = 0;
        stack[top].node = start;
        stack[top].parent = -1;
        stack[top].depth = 1;
        stack[top].start = start;
        top++;

        while (top > 0) {
            State current = stack[--top];
            int u = current.node;
            int parent = current.parent;
            int depth = current.depth;
            int pathStart = current.start;

            if (depth > maxLen) {
                maxLen = depth;
            }

            for (int i = 0; i < graphSize[u]; i++) {
                int v = graph[u][i];
                if (v == parent) continue;

                if (nums[v] == nums[pathStart]) {
                    stack[top].node = v;
                    stack[top].parent = u;
                    stack[top].depth = depth + 1;
                    stack[top].start = pathStart;
                    top++;
                } else {
                    stack[top].node = v;
                    stack[top].parent = u;
                    stack[top].depth = 1;
                    stack[top].start = v;
                    top++;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(degree);
    free(newDegree);
    free(queue);
    free(stack);

    return maxLen;
}