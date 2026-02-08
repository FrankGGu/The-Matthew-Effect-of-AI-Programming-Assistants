bool canVisitAllRooms(int** rooms, int roomsSize, int* roomsColSize) {
    int* visited = (int*)calloc(roomsSize, sizeof(int));
    int* stack = (int*)malloc(roomsSize * sizeof(int));
    int top = -1;

    visited[0] = 1;
    stack[++top] = 0;

    while (top >= 0) {
        int current = stack[top--];
        for (int i = 0; i < roomsColSize[current]; i++) {
            int key = rooms[current][i];
            if (!visited[key]) {
                visited[key] = 1;
                stack[++top] = key;
            }
        }
    }

    for (int i = 0; i < roomsSize; i++) {
        if (!visited[i]) {
            free(visited);
            free(stack);
            return false;
        }
    }

    free(visited);
    free(stack);
    return true;
}