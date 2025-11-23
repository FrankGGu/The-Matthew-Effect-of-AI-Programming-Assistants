/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int node;
    int depth;
} QueueNode;

int* minEdgeReversals(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = edgesSize + 1;
    int* res = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    // Build adjacency list with direction information
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphSize = (int*)calloc(n, sizeof(int));
    int** graphDir = (int**)malloc(n * sizeof(int*));
    int* graphDirSize = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        graphDir[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        graph[u][graphSize[u]] = v;
        graphDir[u][graphDirSize[u]++] = 1; // forward edge
        graphSize[u]++;

        graph[v][graphSize[v]] = u;
        graphDir[v][graphDirSize[v]++] = -1; // reverse edge
        graphSize[v]++;
    }

    // BFS from node 0 to calculate initial cost
    int* visited = (int*)calloc(n, sizeof(int));
    QueueNode* queue = (QueueNode*)malloc(n * sizeof(QueueNode));
    int front = 0, rear = 0;

    queue[rear].node = 0;
    queue[rear].depth = 0;
    rear++;
    visited[0] = 1;

    int initialCost = 0;

    while (front < rear) {
        QueueNode current = queue[front++];
        int u = current.node;

        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            int dir = graphDir[u][i];

            if (!visited[v]) {
                visited[v] = 1;
                if (dir == -1) {
                    initialCost++;
                }
                queue[rear].node = v;
                queue[rear].depth = current.depth + 1;
                rear++;
            }
        }
    }

    // DFS to calculate all costs using re-rooting technique
    res[0] = initialCost;

    int* stack = (int*)malloc(n * sizeof(int));
    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) parent[i] = -1;

    int top = 0;
    stack[top++] = 0;

    while (top > 0) {
        int u = stack[--top];

        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            int dir = graphDir[u][i];

            if (v != parent[u]) {
                parent[v] = u;
                if (dir == 1) {
                    // u->v is forward, so when moving root from u to v, we need to reverse this edge
                    res[v] = res[u] + 1;
                } else {
                    // u->v is reverse (v->u is forward), so when moving root from u to v, we save one reversal
                    res[v] = res[u] - 1;
                }
                stack[top++] = v;
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        free(graph[i]);
        free(graphDir[i]);
    }
    free(graph);
    free(graphDir);
    free(graphSize);
    free(graphDirSize);
    free(visited);
    free(queue);
    free(stack);
    free(parent);

    return res;
}