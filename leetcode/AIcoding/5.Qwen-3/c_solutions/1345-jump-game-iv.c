#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int jumpGameIV(int* arr, int n) {
    if (n == 1) return 0;

    int* visited = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) visited[i] = 0;

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = 0;
    visited[0] = 1;

    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int index = queue[front++];
            if (index == n - 1) {
                free(visited);
                free(queue);
                return steps;
            }

            int next = index + 1;
            if (next < n && !visited[next]) {
                visited[next] = 1;
                queue[rear++] = next;
            }

            int prev = index - 1;
            if (prev >= 0 && !visited[prev]) {
                visited[prev] = 1;
                queue[rear++] = prev;
            }

            int same = index;
            while (same + 1 < n && arr[same] == arr[same + 1]) {
                same++;
            }
            if (same != index && !visited[same]) {
                visited[same] = 1;
                queue[rear++] = same;
            }
        }
        steps++;
    }

    free(visited);
    free(queue);
    return -1;
}