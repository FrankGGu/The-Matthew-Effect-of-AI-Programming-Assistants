int cmp(const void* a, const void* b) {
    int* pa = *(int**)a;
    int* pb = *(int**)b;
    return (pb[0] + pb[1]) - (pa[0] + pa[1]);
}

int stoneGameVI(int* aliceValues, int aliceValuesSize, int* bobValues, int bobValuesSize) {
    int n = aliceValuesSize;
    int** values = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        values[i] = (int*)malloc(2 * sizeof(int));
        values[i][0] = aliceValues[i];
        values[i][1] = bobValues[i];
    }

    qsort(values, n, sizeof(int*), cmp);

    int aliceScore = 0;
    int bobScore = 0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            aliceScore += values[i][0];
        } else {
            bobScore += values[i][1];
        }
    }

    for (int i = 0; i < n; i++) {
        free(values[i]);
    }
    free(values);

    if (aliceScore > bobScore) return 1;
    if (aliceScore < bobScore) return -1;
    return 0;
}