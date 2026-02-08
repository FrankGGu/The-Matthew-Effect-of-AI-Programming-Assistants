int maxWidthOfVerticalArea(int** points, int pointsSize, int* pointsColSize) {
    int* x_coords = (int*)malloc(pointsSize * sizeof(int));
    for (int i = 0; i < pointsSize; i++) {
        x_coords[i] = points[i][0];
    }
    qsort(x_coords, pointsSize, sizeof(int), cmp);

    int max_width = 0;
    for (int i = 1; i < pointsSize; i++) {
        int width = x_coords[i] - x_coords[i - 1];
        if (width > max_width) {
            max_width = width;
        }
    }
    free(x_coords);
    return max_width;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}