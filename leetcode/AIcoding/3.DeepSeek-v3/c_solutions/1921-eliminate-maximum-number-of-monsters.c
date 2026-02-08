int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int eliminateMaximum(int* dist, int distSize, int* speed, int speedSize) {
    int* time = (int*)malloc(distSize * sizeof(int));
    for (int i = 0; i < distSize; i++) {
        time[i] = (dist[i] + speed[i] - 1) / speed[i];
    }

    qsort(time, distSize, sizeof(int), cmp);

    int eliminated = 0;
    for (int minute = 0; minute < distSize; minute++) {
        if (time[minute] <= minute) {
            break;
        }
        eliminated++;
    }

    free(time);
    return eliminated;
}