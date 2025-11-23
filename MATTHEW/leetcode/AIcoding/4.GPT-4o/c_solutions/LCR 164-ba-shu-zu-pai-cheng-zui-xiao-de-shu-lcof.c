char * crackSafe(int n, int k) {
    int totalLength = pow(k, n) + n;
    char *result = malloc(totalLength);
    char *visited = calloc(pow(k, n), sizeof(char));
    int index = 0;

    for (int i = 0; i < n; i++) {
        result[index++] = '0';
    }

    int dfs(char *result, int index, char *visited) {
        if (index == totalLength) {
            return 1;
        }
        int num = 0;
        for (int i = 0; i < pow(k, n); i++) {
            if (visited[i]) continue;
            if (i > 0) {
                result[index++] = '0' + (i % k);
                num++;
            }
            visited[i] = 1;
            if (dfs(result, index, visited)) {
                return 1;
            }
            visited[i] = 0;
            if (i > 0) {
                index--;
            }
        }
        return 0;
    }

    dfs(result, n, visited);
    free(visited);

    return result;
}