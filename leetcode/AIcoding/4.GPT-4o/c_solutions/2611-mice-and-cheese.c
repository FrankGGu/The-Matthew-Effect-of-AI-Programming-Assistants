int miceAndCheese(int* reward1, int reward1Size, int* reward2, int reward2Size, int k) {
    int total = 0;
    int* diff = (int*)malloc(reward1Size * sizeof(int));

    for (int i = 0; i < reward1Size; i++) {
        diff[i] = reward1[i] - reward2[i];
    }

    qsort(diff, reward1Size, sizeof(int), cmp);

    for (int i = 0; i < k; i++) {
        total += reward1[i];
    }

    for (int i = k; i < reward1Size; i++) {
        total += reward2[i];
    }

    free(diff);
    return total;
}

int cmp(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}