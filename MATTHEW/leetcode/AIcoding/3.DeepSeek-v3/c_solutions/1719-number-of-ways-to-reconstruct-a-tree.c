/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    int* pa = *(int**)a;
    int* pb = *(int**)b;
    if (pa[0] == pb[0]) {
        return pa[1] - pb[1];
    }
    return pa[0] - pb[0];
}

int checkWays(int** pairs, int pairsSize, int* pairsColSize) {
    int graph[501][501] = {0};
    int degree[501] = {0};
    int nodes[501] = {0};
    int nodeCount = 0;

    for (int i = 0; i < pairsSize; i++) {
        int u = pairs[i][0];
        int v = pairs[i][1];
        graph[u][v] = 1;
        graph[v][u] = 1;
        degree[u]++;
        degree[v]++;
        if (!nodes[u]) {
            nodes[u] = 1;
            nodeCount++;
        }
        if (!nodes[v]) {
            nodes[v] = 1;
            nodeCount++;
        }
    }

    int* nodeList = (int*)malloc(nodeCount * sizeof(int));
    int idx = 0;
    for (int i = 1; i <= 500; i++) {
        if (nodes[i]) {
            nodeList[idx++] = i;
        }
    }

    for (int i = 0; i < nodeCount; i++) {
        for (int j = i + 1; j < nodeCount; j++) {
            if (degree[nodeList[i]] < degree[nodeList[j]]) {
                int temp = nodeList[i];
                nodeList[i] = nodeList[j];
                nodeList[j] = temp;
            }
        }
    }

    if (degree[nodeList[0]] != nodeCount - 1) {
        free(nodeList);
        return 0;
    }

    int parent[501] = {0};
    int visited[501] = {0};
    visited[nodeList[0]] = 1;

    for (int i = 1; i < nodeCount; i++) {
        int u = nodeList[i];
        for (int j = i - 1; j >= 0; j--) {
            int v = nodeList[j];
            if (graph[u][v]) {
                parent[u] = v;
                visited[u] = 1;
                break;
            }
        }
        if (!visited[u]) {
            free(nodeList);
            return 0;
        }
    }

    int multiple = 0;
    for (int i = 1; i < nodeCount; i++) {
        int u = nodeList[i];
        int p = parent[u];
        if (degree[u] == degree[p]) {
            multiple = 1;
        }
        for (int j = 0; j < i; j++) {
            int v = nodeList[j];
            if (v == p) continue;
            if (graph[u][v] && !graph[p][v]) {
                free(nodeList);
                return 0;
            }
        }
    }

    free(nodeList);
    return multiple ? 2 : 1;
}