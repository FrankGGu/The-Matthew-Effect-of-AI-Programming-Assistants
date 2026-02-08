/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countVisitedNodes(int* edges, int edgesSize, int* returnSize) {
    int n = edgesSize;
    *returnSize = n;
    int* res = (int*)malloc(n * sizeof(int));
    int* indeg = (int*)calloc(n, sizeof(int));
    int* visited = (int*)calloc(n, sizeof(int));
    int* stack = (int*)malloc(n * sizeof(int));
    int top = -1;

    for (int i = 0; i < n; i++) {
        indeg[edges[i]]++;
    }

    for (int i = 0; i < n; i++) {
        if (indeg[i] == 0) {
            stack[++top] = i;
        }
    }

    while (top >= 0) {
        int node = stack[top--];
        int next = edges[node];
        indeg[next]--;
        if (indeg[next] == 0) {
            stack[++top] = next;
        }
    }

    for (int i = 0; i < n; i++) {
        if (visited[i] || indeg[i] == 0) continue;

        int cur = i;
        int cycle_len = 0;
        while (!visited[cur]) {
            visited[cur] = 1;
            cur = edges[cur];
            cycle_len++;
        }

        cur = i;
        while (res[cur] == 0) {
            res[cur] = cycle_len;
            cur = edges[cur];
        }
    }

    for (int i = 0; i < n; i++) {
        if (indeg[i] == 0 && res[i] == 0) {
            int cur = i;
            top = -1;
            while (res[cur] == 0) {
                stack[++top] = cur;
                cur = edges[cur];
            }
            int base = res[cur];
            while (top >= 0) {
                res[stack[top]] = base + (top + 1);
                top--;
            }
        }
    }

    free(indeg);
    free(visited);
    free(stack);
    return res;
}