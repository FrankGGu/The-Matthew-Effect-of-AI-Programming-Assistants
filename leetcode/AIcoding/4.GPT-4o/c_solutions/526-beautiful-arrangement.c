int countArrangement(int N) {
    int count = 0;
    int *visited = (int *)calloc(N + 1, sizeof(int));

    void backtrack(int pos) {
        if (pos > N) {
            count++;
            return;
        }
        for (int i = 1; i <= N; i++) {
            if (!visited[i] && (i % pos == 0 || pos % i == 0)) {
                visited[i] = 1;
                backtrack(pos + 1);
                visited[i] = 0;
            }
        }
    }

    backtrack(1);
    free(visited);
    return count;
}