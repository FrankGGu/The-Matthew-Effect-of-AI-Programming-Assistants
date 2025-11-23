int carFleet(int target, int* position, int positionSize, int* speed, int speedSize) {
    double* time = (double*)malloc(positionSize * sizeof(double));
    for (int i = 0; i < positionSize; i++) {
        time[i] = (double)(target - position[i]) / speed[i];
    }

    qsort(position, positionSize, sizeof(int), cmp);
    qsort(time, positionSize, sizeof(double), cmpTime);

    int fleets = 0;
    double last_time = 0;

    for (int i = positionSize - 1; i >= 0; i--) {
        if (time[i] > last_time) {
            fleets++;
            last_time = time[i];
        }
    }

    free(time);
    return fleets;
}

int cmp(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int cmpTime(const void* a, const void* b) {
    return (*(double*)b - *(double*)a);
}