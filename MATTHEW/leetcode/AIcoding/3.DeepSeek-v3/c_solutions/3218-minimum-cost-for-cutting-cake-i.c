int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int minimumCost(int m, int n, int* horizontalCut, int horizontalCutSize, int* verticalCut, int verticalCutSize) {
    qsort(horizontalCut, horizontalCutSize, sizeof(int), cmp);
    qsort(verticalCut, verticalCutSize, sizeof(int), cmp);

    int h = 0, v = 0;
    int h_segments = 1, v_segments = 1;
    int cost = 0;

    while (h < horizontalCutSize && v < verticalCutSize) {
        if (horizontalCut[h] >= verticalCut[v]) {
            cost += horizontalCut[h] * v_segments;
            h_segments++;
            h++;
        } else {
            cost += verticalCut[v] * h_segments;
            v_segments++;
            v++;
        }
    }

    while (h < horizontalCutSize) {
        cost += horizontalCut[h] * v_segments;
        h++;
    }

    while (v < verticalCutSize) {
        cost += verticalCut[v] * h_segments;
        v++;
    }

    return cost;
}