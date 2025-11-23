typedef struct {
    int x;
    int y;
} Point;

int findMaxValueOfEquation(int** points, int pointsSize, int* pointsColSize, int k) {
    Point* deque = (Point*)malloc(pointsSize * sizeof(Point));
    int front = 0, rear = -1;
    int maxVal = INT_MIN;

    for (int i = 0; i < pointsSize; i++) {
        int x_i = points[i][0];
        int y_i = points[i][1];

        while (front <= rear && x_i - deque[front].x > k) {
            front++;
        }

        if (front <= rear) {
            int val = deque[front].y + y_i + x_i - deque[front].x;
            if (val > maxVal) {
                maxVal = val;
            }
        }

        while (front <= rear && y_i - x_i >= deque[rear].y - deque[rear].x) {
            rear--;
        }

        rear++;
        deque[rear].x = x_i;
        deque[rear].y = y_i;
    }

    free(deque);
    return maxVal;
}