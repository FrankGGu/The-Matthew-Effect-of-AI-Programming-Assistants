int maxCandies(int* status, int statusSize, int* candies, int candiesSize, int** keys, int keysSize, int* keysColSize, int** containedBoxes, int containedBoxesSize, int* containedBoxesColSize, int* initialBoxes, int initialBoxesSize) {
    int n = statusSize;
    int* owned = (int*)calloc(n, sizeof(int));
    int* visited = (int*)calloc(n, sizeof(int));

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < initialBoxesSize; i++) {
        int box = initialBoxes[i];
        owned[box] = 1;
        if (status[box] == 1) {
            queue[rear++] = box;
            visited[box] = 1;
        }
    }

    int total = 0;
    while (front < rear) {
        int curr = queue[front++];
        total += candies[curr];

        for (int i = 0; i < keysColSize[curr]; i++) {
            int key = keys[curr][i];
            if (status[key] == 0) {
                status[key] = 1;
                if (owned[key] && !visited[key]) {
                    queue[rear++] = key;
                    visited[key] = 1;
                }
            }
        }

        for (int i = 0; i < containedBoxesColSize[curr]; i++) {
            int box = containedBoxes[curr][i];
            owned[box] = 1;
            if (status[box] == 1 && !visited[box]) {
                queue[rear++] = box;
                visited[box] = 1;
            }
        }
    }

    free(owned);
    free(visited);
    free(queue);

    return total;
}