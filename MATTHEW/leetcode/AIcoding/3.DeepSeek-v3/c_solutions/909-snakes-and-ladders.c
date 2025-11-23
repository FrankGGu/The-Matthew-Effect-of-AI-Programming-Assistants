int snakesAndLadders(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int total = n * n;
    int* dist = (int*)malloc((total + 1) * sizeof(int));
    for (int i = 0; i <= total; i++) {
        dist[i] = -1;
    }
    dist[1] = 0;

    int* queue = (int*)malloc((total + 1) * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = 1;

    while (front < rear) {
        int curr = queue[front++];

        for (int next = curr + 1; next <= curr + 6 && next <= total; next++) {
            int r = n - 1 - (next - 1) / n;
            int c = ((next - 1) / n) % 2 == 0 ? (next - 1) % n : n - 1 - (next - 1) % n;

            int dest = board[r][c] == -1 ? next : board[r][c];

            if (dist[dest] == -1) {
                dist[dest] = dist[curr] + 1;
                queue[rear++] = dest;
            }
        }
    }

    int result = dist[total];
    free(dist);
    free(queue);
    return result;
}