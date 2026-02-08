int total;

int dfs(char* res, int* visited, int n, int k, int node, int count) {
    if (count == total) return 1;

    for (int i = 0; i < k; i++) {
        int next = node * k + i;
        if (!visited[next]) {
            visited[next] = 1;
            res[count + n - 1] = '0' + i;
            if (dfs(res, visited, n, k, next % total, count + 1)) {
                return 1;
            }
            visited[next] = 0;
        }
    }
    return 0;
}

char* crackSafe(int n, int k) {
    if (n == 1) {
        char* res = (char*)malloc((k + 1) * sizeof(char));
        for (int i = 0; i < k; i++) {
            res[i] = '0' + i;
        }
        res[k] = '\0';
        return res;
    }

    total = 1;
    for (int i = 0; i < n - 1; i++) {
        total *= k;
    }

    int size = total * k + n;
    char* res = (char*)malloc((size + 1) * sizeof(char));
    int* visited = (int*)calloc(total * k, sizeof(int));

    for (int i = 0; i < n - 1; i++) {
        res[i] = '0';
    }

    int start = 0;
    visited[start] = 1;
    dfs(res, visited, n, k, start, 1);

    res[size] = '\0';
    free(visited);
    return res;
}