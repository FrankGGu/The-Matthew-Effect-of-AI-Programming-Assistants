#include <stdbool.h>
#include <stdlib.h>

bool canVisitAllRooms(int** rooms, int roomsSize, int* roomsColSize) {
    if (roomsSize == 0) {
        return true;
    }

    bool* visited = (bool*)malloc(sizeof(bool) * roomsSize);
    for (int i = 0; i < roomsSize; i++) {
        visited[i] = false;
    }

    int* queue = (int*)malloc(sizeof(int) * roomsSize);
    int head = 0;
    int tail = 0;

    queue[tail++] = 0;
    visited[0] = true;
    int visited_count = 1;

    while (head < tail) {
        int current_room = queue[head++];

        for (int i = 0; i < roomsColSize[current_room]; i++) {
            int next_room = rooms[current_room][i];

            if (!visited[next_room]) {
                visited[next_room] = true;
                queue[tail++] = next_room;
                visited_count++;
            }
        }
    }

    free(visited);
    free(queue);

    return visited_count == roomsSize;
}