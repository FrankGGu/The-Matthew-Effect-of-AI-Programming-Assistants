#include <stdio.h>
#include <stdlib.h>

#define INF 1000000000

typedef struct {
    int time;
    int room;
} Node;

int minTime(int** A, int ASize, int* AColSize) {
    int n = ASize;
    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dist[i] = INF;
    dist[0] = 0;

    Node* queue = (Node*)malloc(n * sizeof(Node));
    int front = 0, rear = 0;
    queue[rear++] = (Node){0, 0};

    while (front < rear) {
        Node current = queue[front++];
        int currentTime = current.time;
        int currentRoom = current.room;

        for (int i = 0; i < AColSize[currentRoom]; i++) {
            int nextRoom = A[currentRoom][i];
            if (dist[nextRoom] > currentTime + 1) {
                dist[nextRoom] = currentTime + 1;
                queue[rear++] = (Node){dist[nextRoom], nextRoom};
            }
        }
    }

    int result = dist[n - 1];
    free(dist);
    free(queue);

    return result == INF ? -1 : result;
}