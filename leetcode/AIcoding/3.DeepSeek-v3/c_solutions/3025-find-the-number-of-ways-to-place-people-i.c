int compare(const void* a, const void* b) {
    int* pointA = *(int**)a;
    int* pointB = *(int**)b;
    if (pointA[0] == pointB[0]) {
        return pointA[1] - pointB[1];
    }
    return pointA[0] - pointB[0];
}

int numberOfPairs(int** points, int pointsSize, int* pointsColSize) {
    qsort(points, pointsSize, sizeof(int*), compare);

    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i][0] <= points[j][0] && points[i][1] >= points[j][1]) {
                int valid = 1;
                for (int k = 0; k < pointsSize; k++) {
                    if (k != i && k != j) {
                        if (points[k][0] >= points[i][0] && points[k][0] <= points[j][0] &&
                            points[k][1] <= points[i][1] && points[k][1] >= points[j][1]) {
                            valid = 0;
                            break;
                        }
                    }
                }
                if (valid) {
                    count++;
                }
            }
        }
    }
    return count;
}