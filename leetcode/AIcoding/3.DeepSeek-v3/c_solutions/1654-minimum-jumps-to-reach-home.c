int minimumJumps(int* forbidden, int forbiddenSize, int a, int b, int x) {
    if (x == 0) return 0;

    int max_pos = 2000 + a + b;
    int* visited = (int*)calloc(max_pos + 1, sizeof(int));
    int* forbid = (int*)calloc(max_pos + 1, sizeof(int));

    for (int i = 0; i < forbiddenSize; i++) {
        if (forbidden[i] <= max_pos) {
            forbid[forbidden[i]] = 1;
        }
    }

    int queue_size = 100000;
    int* queue_pos = (int*)malloc(queue_size * sizeof(int));
    int* queue_steps = (int*)malloc(queue_size * sizeof(int));
    int* queue_back = (int*)malloc(queue_size * sizeof(int));

    int front = 0, rear = 0;
    queue_pos[rear] = 0;
    queue_steps[rear] = 0;
    queue_back[rear] = 0;
    rear++;
    visited[0] = 1;

    while (front < rear) {
        int pos = queue_pos[front];
        int steps = queue_steps[front];
        int back_count = queue_back[front];
        front++;

        if (pos == x) {
            free(visited);
            free(forbid);
            free(queue_pos);
            free(queue_steps);
            free(queue_back);
            return steps;
        }

        int next_forward = pos + a;
        if (next_forward <= max_pos && !forbid[next_forward] && !visited[next_forward]) {
            visited[next_forward] = 1;
            queue_pos[rear] = next_forward;
            queue_steps[rear] = steps + 1;
            queue_back[rear] = 0;
            rear++;
        }

        int next_backward = pos - b;
        if (next_backward >= 0 && !forbid[next_backward] && !visited[next_backward] && back_count == 0) {
            visited[next_backward] = 1;
            queue_pos[rear] = next_backward;
            queue_steps[rear] = steps + 1;
            queue_back[rear] = 1;
            rear++;
        }
    }

    free(visited);
    free(forbid);
    free(queue_pos);
    free(queue_steps);
    free(queue_back);
    return -1;
}