int racecar(int target) {
    int queue[10000][2], front = 0, rear = 0, visited[10000] = {0};
    queue[rear][0] = 0; // position
    queue[rear][1] = 1; // speed
    rear++;
    visited[0] = 1;
    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int pos = queue[front][0], speed = queue[front][1];
            front++;
            if (pos == target) return steps;

            // Accelerate
            int nextPos = pos + speed;
            int nextSpeed = speed * 2;
            if (nextPos >= 0 && nextPos < 10000 && !visited[nextPos]) {
                visited[nextPos] = 1;
                queue[rear][0] = nextPos;
                queue[rear][1] = nextSpeed;
                rear++;
            }

            // Reverse
            nextPos = pos;
            nextSpeed = speed > 0 ? -1 : 1;
            if (nextPos >= 0 && nextPos < 10000 && !visited[nextPos]) {
                visited[nextPos] = 1;
                queue[rear][0] = nextPos;
                queue[rear][1] = nextSpeed;
                rear++;
            }
        }
        steps++;
    }
    return -1;
}