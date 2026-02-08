int maxTasty(int* price, int priceSize, int k) {
    int left = 1, right = 1e9, maxTasty = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 0, lastPicked = -1;

        for (int i = 0; i < priceSize; i++) {
            if (price[i] - lastPicked >= mid) {
                count++;
                lastPicked = price[i];
                if (count == k) break;
            }
        }

        if (count >= k) {
            maxTasty = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return maxTasty;
}