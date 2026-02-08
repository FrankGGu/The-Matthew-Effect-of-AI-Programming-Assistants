int minWastedSpace(int* packages, int packagesSize, int** boxes, int boxesSize, int* boxesColSize) {
    int total = 0;
    for (int i = 0; i < packagesSize; i++) total += packages[i];

    qsort(packages, packagesSize, sizeof(int), cmp);

    int minWaste = INT_MAX;

    for (int i = 0; i < boxesSize; i++) {
        int boxSize = boxesColSize[i];
        if (boxSize < packagesSize) continue;

        qsort(boxes[i], boxSize, sizeof(int), cmp);

        int waste = 0, j = 0, k = 0;
        while (j < packagesSize && k < boxSize) {
            if (packages[j] <= boxes[i][k]) {
                waste += boxes[i][k];
                k++;
            }
            j++;
        }
        waste -= total;
        minWaste = minWaste < waste ? minWaste : waste;
    }

    return minWaste == INT_MAX ? -1 : minWaste;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}