int findRadius(int* houses, int housesSize, int* heaters, int heatersSize) {
    int radius = 0;
    qsort(houses, housesSize, sizeof(int), cmp);
    qsort(heaters, heatersSize, sizeof(int), cmp);

    for (int i = 0; i < housesSize; i++) {
        int h = binarySearch(heaters, heatersSize, houses[i]);
        int dist = abs(houses[i] - h);
        if (dist > radius) {
            radius = dist;
        }
    }

    return radius;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int binarySearch(int* heaters, int size, int house) {
    int left = 0, right = size - 1;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (heaters[mid] < house) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    if (left == size || (left > 0 && abs(heaters[left - 1] - house) <= abs(heaters[left] - house))) {
        return heaters[left - 1];
    }
    return heaters[left];
}