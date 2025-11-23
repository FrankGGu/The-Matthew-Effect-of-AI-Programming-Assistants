bool canVisitAllRooms(int** rooms, int roomsSize, int* roomsColSize) {
    bool* visited = (bool*)calloc(roomsSize, sizeof(bool));
    int stack[roomsSize];
    int top = 0;

    visited[0] = true;
    stack[top++] = 0;

    while (top > 0) {
        int curr = stack[--top];
        for (int i = 0; i < roomsColSize[curr]; i++) {
            int nextRoom = rooms[curr][i];
            if (!visited[nextRoom]) {
                visited[nextRoom] = true;
                stack[top++] = nextRoom;
            }
        }
    }

    for (int i = 0; i < roomsSize; i++) {
        if (!visited[i]) {
            free(visited);
            return false;
        }
    }

    free(visited);
    return true;
}