int cmp(const void* a, const void* b) {
    int* eventA = *(int**)a;
    int* eventB = *(int**)b;
    return eventA[0] - eventB[0];
}

int maxTwoEvents(int** events, int eventsSize, int* eventsColSize) {
    qsort(events, eventsSize, sizeof(int*), cmp);

    int* maxSuffix = malloc(eventsSize * sizeof(int));
    maxSuffix[eventsSize - 1] = events[eventsSize - 1][2];

    for (int i = eventsSize - 2; i >= 0; i--) {
        maxSuffix[i] = (events[i][2] > maxSuffix[i + 1]) ? events[i][2] : maxSuffix[i + 1];
    }

    int maxSum = 0;
    for (int i = 0; i < eventsSize; i++) {
        int currentVal = events[i][2];
        int left = i + 1, right = eventsSize - 1;
        int nextIndex = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (events[mid][0] > events[i][1]) {
                nextIndex = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        if (nextIndex != -1) {
            currentVal += maxSuffix[nextIndex];
        }

        if (currentVal > maxSum) {
            maxSum = currentVal;
        }
    }

    for (int i = 0; i < eventsSize; i++) {
        if (events[i][2] > maxSum) {
            maxSum = events[i][2];
        }
    }

    free(maxSuffix);
    return maxSum;
}