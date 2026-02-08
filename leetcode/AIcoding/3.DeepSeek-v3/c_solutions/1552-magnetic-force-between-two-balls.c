int maxDistance(int* position, int positionSize, int m) {
    int cmp(const void* a, const void* b) {
        return *(int*)a - *(int*)b;
    }
    qsort(position, positionSize, sizeof(int), cmp);

    int left = 1;
    int right = position[positionSize - 1] - position[0];
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 1;
        int last = position[0];

        for (int i = 1; i < positionSize; i++) {
            if (position[i] - last >= mid) {
                count++;
                last = position[i];
            }
        }

        if (count >= m) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}