int minimumOperations(int* nums, int numsSize, int start, int goal) {
    int queue[1001];
    int front = 0, rear = 0;
    int visited[1001] = {0};

    queue[rear++] = start;
    visited[start] = 1;
    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int current = queue[front++];

            for (int j = 0; j < numsSize; j++) {
                int next1 = current + nums[j];
                int next2 = current - nums[j];
                int next3 = current ^ nums[j];

                if (next1 == goal || next2 == goal || next3 == goal) {
                    return steps + 1;
                }

                if (next1 >= 0 && next1 <= 1000 && !visited[next1]) {
                    visited[next1] = 1;
                    queue[rear++] = next1;
                }
                if (next2 >= 0 && next2 <= 1000 && !visited[next2]) {
                    visited[next2] = 1;
                    queue[rear++] = next2;
                }
                if (next3 >= 0 && next3 <= 1000 && !visited[next3]) {
                    visited[next3] = 1;
                    queue[rear++] = next3;
                }
            }
        }
        steps++;
    }

    return -1;
}