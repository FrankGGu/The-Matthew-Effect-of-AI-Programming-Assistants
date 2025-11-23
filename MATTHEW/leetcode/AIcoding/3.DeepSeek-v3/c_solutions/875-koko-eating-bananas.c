int minEatingSpeed(int* piles, int pilesSize, int h) {
    int left = 1;
    int right = 0;

    for (int i = 0; i < pilesSize; i++) {
        if (piles[i] > right) {
            right = piles[i];
        }
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        long long hours = 0;

        for (int i = 0; i < pilesSize; i++) {
            hours += (piles[i] + mid - 1) / mid;
        }

        if (hours <= h) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}