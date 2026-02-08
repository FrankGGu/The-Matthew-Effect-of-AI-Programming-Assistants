char * crackSafe(int n, int k) {
    int total = pow(k, n);
    char *result = (char *)malloc(sizeof(char) * (total + n + 1));
    int index = 0;

    // Initialize the result with the first combination
    for (int i = 0; i < n; i++) {
        result[index++] = '0';
    }

    result[index] = '\0';
    // Track visited combinations
    int visited[10000] = {0};
    visited[0] = 1;

    for (int i = 0; i < total; i++) {
        int curr = 0;
        for (int j = 0; j < n; j++) {
            curr = curr * 10 + (result[index - n + j] - '0');
        }
        for (int j = 0; j < k; j++) {
            int next = curr * 10 + j;
            if (!visited[next]) {
                visited[next] = 1;
                result[index++] = '0' + j;
                break;
            }
        }
    }

    result[index] = '\0';
    return result;
}