/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* maximumScoreAfterOperations(int** edges, int edgesSize, int* edgesColSize, int* values, int valuesSize, int* returnSize) {
    *returnSize = 0;
    if (edgesSize == 0) {
        long long* res = malloc(sizeof(long long));
        *res = 0;
        *returnSize = 1;
        return res;
    }

    int n = valuesSize;
    long long total = 0;
    for (int i = 0; i < n; i++) {
        total += values[i];
    }

    int* degree = calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    int* queue = malloc(n * sizeof(int));
    int front = 0, rear = 0;
    for (int i = 1; i < n; i++) {
        if (degree[i] == 1) {
            queue[rear++] = i;
        }
    }

    long long min_sum = 0;
    int* visited = calloc(n, sizeof(int));

    while (front < rear) {
        int node = queue[front++];
        visited[node] = 1;

        int parent = -1;
        for (int i = 0; i < edgesSize; i++) {
            if (edges[i][0] == node && !visited[edges[i][1]]) {
                parent = edges[i][1];
                break;
            }
            if (edges[i][1] == node && !visited[edges[i][0]]) {
                parent = edges[i][0];
                break;
            }
        }

        if (parent != -1) {
            if (values[node] < values[parent]) {
                values[parent] = values[node];
            }
            degree[parent]--;
            if (degree[parent] == 1 && parent != 0) {
                queue[rear++] = parent;
            }
        } else {
            min_sum += values[node];
        }
    }

    long long* res = malloc(sizeof(long long));
    *res = total - min_sum;
    *returnSize = 1;

    free(degree);
    free(queue);
    free(visited);

    return res;
}