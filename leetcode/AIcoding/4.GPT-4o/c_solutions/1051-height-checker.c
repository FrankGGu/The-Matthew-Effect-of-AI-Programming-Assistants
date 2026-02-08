int heightChecker(int* heights, int heightsSize) {
    int* expected = (int*)malloc(heightsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < heightsSize; i++) {
        expected[i] = heights[i];
    }

    qsort(expected, heightsSize, sizeof(int), cmp);

    for (int i = 0; i < heightsSize; i++) {
        if (heights[i] != expected[i]) {
            count++;
        }
    }

    free(expected);
    return count;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}