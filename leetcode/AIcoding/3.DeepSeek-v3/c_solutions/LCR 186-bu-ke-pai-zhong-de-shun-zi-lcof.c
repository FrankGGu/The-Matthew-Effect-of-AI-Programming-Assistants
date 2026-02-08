int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int checkDynasty(int* places, int placesSize) {
    qsort(places, placesSize, sizeof(int), cmp);
    int zeroCount = 0;
    int i = 0;
    while (i < placesSize && places[i] == 0) {
        zeroCount++;
        i++;
    }
    for (int j = i; j < placesSize - 1; j++) {
        int gap = places[j + 1] - places[j] - 1;
        if (gap < 0) return 0;
        zeroCount -= gap;
        if (zeroCount < 0) return 0;
    }
    return 1;
}