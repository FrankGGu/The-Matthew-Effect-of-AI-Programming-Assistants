int shipWithinDays(int* weights, int weightsSize, int D) {
    int left = 0, right = 0;
    for (int i = 0; i < weightsSize; i++) {
        left = left > weights[i] ? left : weights[i];
        right += weights[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int days = 1, currentWeight = 0;

        for (int i = 0; i < weightsSize; i++) {
            if (currentWeight + weights[i] > mid) {
                days++;
                currentWeight = weights[i];
            } else {
                currentWeight += weights[i];
            }
        }

        if (days > D) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}