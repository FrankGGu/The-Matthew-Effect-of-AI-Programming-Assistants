#include <stdio.h>
#include <stdlib.h>

bool canVisitAllRooms(int** rooms, int roomsSize, int* roomsColSize) {
    int* visited = (int*)malloc(roomsSize * sizeof(int));
    for (int i = 0; i < roomsSize; i++) {
        visited[i] = 0;
    }

    void dfs(int room) {
        visited[room] = 1;
        for (int i = 0; i < roomsColSize[room]; i++) {
            if (!visited[rooms[room][i]]) {
                dfs(rooms[room][i]);
            }
        }
    }

    dfs(0);

    for (int i = 0; i < roomsSize; i++) {
        if (!visited[i]) {
            free(visited);
            return false;
        }
    }

    free(visited);
    return true;
}