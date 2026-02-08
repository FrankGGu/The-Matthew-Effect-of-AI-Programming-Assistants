int smallestChair(int** times, int timesSize, int* timesColSize) {
    int chairs[1000] = {0};
    int maxTime = 0;
    for (int i = 0; i < timesSize; i++) {
        if (times[i][1] > maxTime) {
            maxTime = times[i][1];
        }
    }

    int events[2000][2];
    for (int i = 0; i < timesSize; i++) {
        events[i * 2][0] = times[i][0];
        events[i * 2][1] = 1;
        events[i * 2 + 1][0] = times[i][1];
        events[i * 2 + 1][1] = -1;
    }

    qsort(events, 2 * timesSize, sizeof(events[0]), [](const void *a, const void *b) {
        return (*(int(*)[2])a)[0] - (*(int(*)[2])b)[0];
    });

    int availableChairs = 0;
    for (int i = 0; i < 2 * timesSize; i++) {
        if (events[i][1] == 1) {
            while (chairs[availableChairs]) {
                availableChairs++;
            }
            chairs[availableChairs] = 1;
            if (i == 0) {
                return availableChairs;
            }
        } else {
            for (int j = 0; j < 1000; j++) {
                if (chairs[j] == 1) {
                    chairs[j] = 0;
                    break;
                }
            }
        }
    }

    return -1;
}