int findMaxValueOfEquation(int** points, int pointsSize, int* pointsColSize, int k) {
    int maxVal = -2147483648;
    int* deque = (int*)malloc(pointsSize * sizeof(int));
    int front = 0, back = 0;

    for (int i = 0; i < pointsSize; i++) {
        while (front < back && points[i][0] - points[deque[front]][0] > k) {
            front++;
        }
        if (front < back) {
            maxVal = fmax(maxVal, points[i][0] + points[i][1] + points[deque[front]][1] - points[deque[front]][0]);
        }
        while (front < back && points[deque[back - 1]][1] - points[deque[back - 1]][0] <= points[i][1] - points[i][0]) {
            back--;
        }
        deque[back++] = i;
    }

    free(deque);
    return maxVal;
}