int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int miceAndCheese(int* reward1, int reward1Size, int* reward2, int reward2Size, int k) {
    int n = reward1Size;
    int* diff = (int*)malloc(n * sizeof(int));
    int total = 0;

    for (int i = 0; i < n; i++) {
        total += reward2[i];
        diff[i] = reward1[i] - reward2[i];
    }

    qsort(diff, n, sizeof(int), cmp);

    for (int i = 0; i < k; i++) {
        total += diff[i];
    }

    free(diff);
    return total;
}