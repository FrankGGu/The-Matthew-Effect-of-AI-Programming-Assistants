int maxDistance(int* position, int positionSize, int m) {
    qsort(position, positionSize, sizeof(int), cmp);
    int left = 1, right = position[positionSize - 1] - position[0], result = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2, count = 1, lastPos = position[0];
        for (int i = 1; i < positionSize; i++) {
            if (position[i] - lastPos >= mid) {
                count++;
                lastPos = position[i];
            }
        }
        if (count >= m) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}