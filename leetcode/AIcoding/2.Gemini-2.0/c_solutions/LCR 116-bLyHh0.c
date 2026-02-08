#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findCircleNum(int** isConnected, int n, int* isConnectedColSize){
    int visited[n];
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            count++;

            int queue[n];
            int head = 0;
            int tail = 0;
            queue[tail++] = i;
            visited[i] = 1;

            while (head < tail) {
                int u = queue[head++];
                for (int v = 0; v < n; v++) {
                    if (isConnected[u][v] == 1 && !visited[v]) {
                        queue[tail++] = v;
                        visited[v] = 1;
                    }
                }
            }
        }
    }

    return count;
}