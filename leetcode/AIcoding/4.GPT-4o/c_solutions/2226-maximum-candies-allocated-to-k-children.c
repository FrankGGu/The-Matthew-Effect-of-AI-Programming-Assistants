int maxCandies(int* candies, int candiesSize, int k) {
    int left = 1, right = 0;
    for (int i = 0; i < candiesSize; i++) {
        right += candies[i];
    }

    int result = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 0;
        for (int i = 0; i < candiesSize; i++) {
            count += candies[i] / mid;
        }
        if (count >= k) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
}