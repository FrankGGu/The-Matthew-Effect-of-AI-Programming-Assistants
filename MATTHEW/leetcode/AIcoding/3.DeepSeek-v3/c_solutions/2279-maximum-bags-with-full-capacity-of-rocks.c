int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maximumBags(int* capacity, int capacitySize, int* rocks, int rocksSize, int additionalRocks) {
    int* diff = (int*)malloc(capacitySize * sizeof(int));
    for (int i = 0; i < capacitySize; i++) {
        diff[i] = capacity[i] - rocks[i];
    }

    qsort(diff, capacitySize, sizeof(int), compare);

    int count = 0;
    for (int i = 0; i < capacitySize; i++) {
        if (diff[i] <= additionalRocks) {
            additionalRocks -= diff[i];
            count++;
        } else {
            break;
        }
    }

    free(diff);
    return count;
}