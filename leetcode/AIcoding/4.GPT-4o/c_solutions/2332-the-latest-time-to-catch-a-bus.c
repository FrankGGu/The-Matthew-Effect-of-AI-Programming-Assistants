int latestTimeToCatchBus(int* buses, int busesSize, int* passengers, int passengersSize, int capacity) {
    int i = 0, j = 0, count = 0, latest = 0;

    qsort(buses, busesSize, sizeof(int), cmp);
    qsort(passengers, passengersSize, sizeof(int), cmp);

    while (i < busesSize) {
        count = 0;
        while (j < passengersSize && passengers[j] <= buses[i] && count < capacity) {
            if (passengers[j] == latest) latest--;
            count++;
            j++;
        }
        latest = buses[i];
        i++;
    }

    while (j > 0 && count > 0) {
        if (passengers[j - 1] < latest) break;
        latest--;
        count--;
        j--;
    }

    return latest;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}