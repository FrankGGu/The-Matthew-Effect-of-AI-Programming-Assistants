int minDays(int* bloomDay, int bloomDaySize, int m, int k) {
    if ((long long)m * k > bloomDaySize) return -1;

    int left = 1, right = 1;
    for (int i = 0; i < bloomDaySize; i++) {
        if (bloomDay[i] > right) right = bloomDay[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int bouquets = 0;
        int flowers = 0;

        for (int i = 0; i < bloomDaySize; i++) {
            if (bloomDay[i] <= mid) {
                flowers++;
                if (flowers == k) {
                    bouquets++;
                    flowers = 0;
                }
            } else {
                flowers = 0;
            }
        }

        if (bouquets >= m) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}