#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canVisitAllRooms(int** rooms, int roomsSize, int* roomsColSize){
    bool* visited = (bool*)malloc(roomsSize * sizeof(bool));
    for (int i = 0; i < roomsSize; i++) {
        visited[i] = false;
    }

    int* queue = (int*)malloc(roomsSize * sizeof(int));
    int head = 0, tail = 0;

    queue[tail++] = 0;
    visited[0] = true;

    int count = 0;

    while (head < tail) {
        int room = queue[head++];
        count++;

        for (int i = 0; i < roomsColSize[room]; i++) {
            int key = rooms[room][i];
            if (!visited[key]) {
                visited[key] = true;
                queue[tail++] = key;
            }
        }
    }

    free(queue);
    free(visited);

    return count == roomsSize;
}