int count;

void backtrack(int n, int pos, int* visited) {
    if (pos > n) {
        count++;
        return;
    }

    for (int i = 1; i <= n; i++) {
        if (!visited[i] && (i % pos == 0 || pos % i == 0)) {
            visited[i] = 1;
            backtrack(n, pos + 1, visited);
            visited[i] = 0;
        }
    }
}

int countArrangement(int n) {
    count = 0;
    int* visited = (int*)calloc(n + 1, sizeof(int));
    backtrack(n, 1, visited);
    free(visited);
    return count;
}