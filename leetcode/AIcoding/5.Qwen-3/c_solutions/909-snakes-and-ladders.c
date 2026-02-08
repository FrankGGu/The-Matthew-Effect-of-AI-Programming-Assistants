#include <stdio.h>
#include <stdlib.h>

int snakesAndLadders(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int queue[10000];
    int visited[10000] = {0};
    int front = 0, rear = 0;
    queue[rear++] = 1;
    visited[1] = 1;
    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int current = queue[front++];
            if (current == n * n) return steps;
            for (int dice = 1; dice <= 6; dice++) {
                int next = current + dice;
                if (next > n * n) continue;
                int row = (next - 1) / n;
                int col = (next - 1) % n;
                if (row % 2 == 1) col = n - 1 - col;
                row = n - 1 - row;
                if (board[row][col] != -1) next = board[row][col];
                if (!visited[next]) {
                    visited[next] = 1;
                    queue[rear++] = next;
                }
            }
        }
        steps++;
    }
    return -1;
}