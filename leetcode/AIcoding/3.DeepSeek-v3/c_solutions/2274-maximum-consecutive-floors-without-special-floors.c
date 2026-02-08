int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maxConsecutive(int bottom, int top, int* special, int specialSize) {
    qsort(special, specialSize, sizeof(int), cmp);

    int max = 0;

    max = fmax(max, special[0] - bottom);

    for (int i = 1; i < specialSize; i++) {
        max = fmax(max, special[i] - special[i-1] - 1);
    }

    max = fmax(max, top - special[specialSize - 1]);

    return max;
}