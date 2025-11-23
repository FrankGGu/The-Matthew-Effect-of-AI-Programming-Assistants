int minMutation(char* start, char* end, char** bank, int bankSize) {
    if (bankSize == 0) return -1;

    char* queue[bankSize + 1];
    int front = 0, rear = 0;
    int visited[bankSize];
    memset(visited, 0, sizeof(visited));

    queue[rear++] = start;
    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            char* current = queue[front++];
            if (strcmp(current, end) == 0) return steps;

            for (int j = 0; j < bankSize; j++) {
                if (visited[j]) continue;

                int diff = 0;
                for (int k = 0; k < 8; k++) {
                    if (current[k] != bank[j][k]) diff++;
                    if (diff > 1) break;
                }

                if (diff == 1) {
                    visited[j] = 1;
                    queue[rear++] = bank[j];
                }
            }
        }
        steps++;
    }

    return -1;
}