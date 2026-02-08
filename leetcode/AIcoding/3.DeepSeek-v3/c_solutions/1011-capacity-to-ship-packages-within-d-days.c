int shipWithinDays(int* weights, int weightsSize, int days) {
    int left = 0, right = 0;
    for (int i = 0; i < weightsSize; i++) {
        if (weights[i] > left) left = weights[i];
        right += weights[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int current = 0, needed = 1;

        for (int i = 0; i < weightsSize; i++) {
            if (current + weights[i] > mid) {
                needed++;
                current = 0;
            }
            current += weights[i];
        }

        if (needed <= days) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}