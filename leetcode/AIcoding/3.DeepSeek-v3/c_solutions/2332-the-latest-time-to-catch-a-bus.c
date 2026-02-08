int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int latestTimeCatchTheBus(int* buses, int busesSize, int* passengers, int passengersSize, int capacity) {
    qsort(buses, busesSize, sizeof(int), cmp);
    qsort(passengers, passengersSize, sizeof(int), cmp);

    int j = 0;
    int last_passenger = 0;

    for (int i = 0; i < busesSize; i++) {
        int count = 0;
        while (j < passengersSize && passengers[j] <= buses[i] && count < capacity) {
            last_passenger = passengers[j];
            j++;
            count++;
        }

        if (i == busesSize - 1) {
            if (count < capacity) {
                int time = buses[i];
                while (j > 0 && passengers[j - 1] == time) {
                    j--;
                    time--;
                }
                return time;
            } else {
                int time = last_passenger - 1;
                while (j > 0 && passengers[j - 1] == time) {
                    j--;
                    time--;
                }
                return time;
            }
        }
    }

    return -1;
}