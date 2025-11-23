int minDays(int* bloomDay, int bloomDaySize, int m, int k) {
    if (m * k > bloomDaySize) return -1;

    int left = 1, right = 1000000000, res = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 0, currBouquet = 0;

        for (int i = 0; i < bloomDaySize; i++) {
            if (bloomDay[i] <= mid) {
                currBouquet++;
                if (currBouquet == k) {
                    count++;
                    currBouquet = 0;
                }
            } else {
                currBouquet = 0;
            }
        }

        if (count >= m) {
            res = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return res;
}