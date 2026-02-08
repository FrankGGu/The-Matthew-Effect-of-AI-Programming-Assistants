int findMinArrowShots(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize == 0) return 0;

    // Sort the points based on the end position
    qsort(points, pointsSize, sizeof(int*), [](const void* a, const void* b) {
        return (*(int**)a)[1] - (*(int**)b)[1];
    });

    int arrows = 1;
    int end = points[0][1];

    for (int i = 1; i < pointsSize; i++) {
        if (points[i][0] > end) {
            arrows++;
            end = points[i][1];
        }
    }

    return arrows;
}