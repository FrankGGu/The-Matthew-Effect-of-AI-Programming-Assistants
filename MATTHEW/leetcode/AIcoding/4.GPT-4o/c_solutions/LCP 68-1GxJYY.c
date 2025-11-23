int minCost(int* bloomDay, int bloomDaySize, int m, int k) {
    if (m * k > bloomDaySize) return -1;

    int left = 1, right = 1e9, ans = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 0, bouquets = 0;

        for (int i = 0; i < bloomDaySize; i++) {
            if (bloomDay[i] <= mid) {
                count++;
                if (count == k) {
                    bouquets++;
                    count = 0;
                }
            } else {
                count = 0;
            }
        }

        if (bouquets >= m) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}