int openLock(char** deadends, int deadendsSize, char* target) {
    int visited[10000] = {0};

    for (int i = 0; i < deadendsSize; i++) {
        int num = atoi(deadends[i]);
        visited[num] = 1;
    }

    if (visited[0]) return -1;

    int target_num = atoi(target);
    if (target_num == 0) return 0;

    int queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = 0;
    visited[0] = 1;
    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int current = queue[front++];
            if (current == target_num) return steps;

            for (int j = 0; j < 4; j++) {
                int digit = (current / (int)pow(10, j)) % 10;

                int next1 = current - digit * (int)pow(10, j) + ((digit + 1) % 10) * (int)pow(10, j);
                if (!visited[next1]) {
                    visited[next1] = 1;
                    queue[rear++] = next1;
                }

                int next2 = current - digit * (int)pow(10, j) + ((digit + 9) % 10) * (int)pow(10, j);
                if (!visited[next2]) {
                    visited[next2] = 1;
                    queue[rear++] = next2;
                }
            }
        }
        steps++;
    }

    return -1;
}