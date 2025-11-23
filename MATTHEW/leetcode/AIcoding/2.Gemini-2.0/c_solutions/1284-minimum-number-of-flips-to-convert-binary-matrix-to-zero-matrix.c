#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlips(int** mat, int matSize, int* matColSize){
    int m = matSize, n = matColSize[0];
    int start = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            start |= (mat[i][j] << (i * n + j));
        }
    }

    int queue[1 << 12];
    int head = 0, tail = 0;
    queue[tail++] = start;

    bool visited[1 << 12];
    for (int i = 0; i < (1 << 12); i++) {
        visited[i] = false;
    }
    visited[start] = true;

    int level = 0;
    while (head < tail) {
        int size = tail - head;
        for (int k = 0; k < size; k++) {
            int curr = queue[head++];
            if (curr == 0) {
                return level;
            }

            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    int next = curr;
                    next ^= (1 << (i * n + j));
                    if (i > 0) next ^= (1 << ((i - 1) * n + j));
                    if (i < m - 1) next ^= (1 << ((i + 1) * n + j));
                    if (j > 0) next ^= (1 << (i * n + (j - 1)));
                    if (j < n - 1) next ^= (1 << (i * n + (j + 1)));

                    if (!visited[next]) {
                        visited[next] = true;
                        queue[tail++] = next;
                    }
                }
            }
        }
        level++;
    }

    return -1;
}