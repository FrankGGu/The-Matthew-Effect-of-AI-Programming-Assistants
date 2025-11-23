#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int snakesAndLadders(int** board, int boardSize) {
    int n = boardSize;
    int* visited = (int*)calloc(n * n + 1, sizeof(int));
    int* queue = (int*)malloc((n * n + 1) * sizeof(int));
    int head = 0;
    int tail = 0;

    queue[tail++] = 1;
    visited[1] = 1;

    int moves = 0;
    while (head < tail) {
        int size = tail - head;
        for (int i = 0; i < size; i++) {
            int curr = queue[head++];
            if (curr == n * n) {
                free(visited);
                free(queue);
                return moves;
            }

            for (int next = curr + 1; next <= curr + 6 && next <= n * n; next++) {
                int row = (next - 1) / n;
                int col = (next - 1) % n;
                row = n - 1 - row;
                if ((n % 2 == 0 && (n - 1 - row) % 2 != 0) || (n % 2 != 0 && (n - 1 - row) % 2 == 0)) {
                    col = n - 1 - col;
                }

                int dest = (board[row][col] == -1) ? next : board[row][col];

                if (!visited[dest]) {
                    visited[dest] = 1;
                    queue[tail++] = dest;
                }
            }
        }
        moves++;
    }

    free(visited);
    free(queue);
    return -1;
}