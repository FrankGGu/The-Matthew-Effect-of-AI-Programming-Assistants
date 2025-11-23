int eliminateMaximum(int* dist, int distSize, int* speed, int speedSize) {
    int n = distSize;
    int times[n];

    for (int i = 0; i < n; i++) {
        times[i] = (dist[i] + speed[i] - 1) / speed[i];
    }

    qsort(times, n, sizeof(int), cmp);

    for (int i = 0; i < n; i++) {
        if (times[i] <= i) return i;
    }

    return n;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}