int cmp(const void* a, const void* b) {
    int* pa = *(int**)a;
    int* pb = *(int**)b;
    if (pa[0] == pb[0]) {
        return pb[1] - pa[1];
    }
    return pa[0] - pb[0];
}

int numberOfPairs(int** points, int pointsSize, int* pointsColSize) {
    qsort(points, pointsSize, sizeof(int*), cmp);

    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i][0] <= points[j][0] && points[i][1] >= points[j][1]) {
                int valid = 1;
                for (int k = i + 1; k < j; k++) {
                    if (points[k][0] >= points[i][0] && points[k][0] <= points[j][0] &&
                        points[k][1] <= points[i][1] && points[k][1] >= points[j][1]) {
                        valid = 0;
                        break;
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