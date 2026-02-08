int maxValue(int n, int index, int maxSum) {
    int left = index, right = n - index - 1;
    int low = 1, high = maxSum;

    while (low < high) {
        int mid = (low + high + 1) / 2;
        long long total = mid;

        if (left > 0) {
            long long leftSum = mid - 1 >= left ? (mid * (mid - 1) / 2) - ((mid - left) * (mid - left - 1) / 2) : (mid * (mid - 1) / 2);
            total += leftSum;
        }

        if (right > 0) {
            long long rightSum = mid - 1 >= right ? (mid * (mid - 1) / 2) - ((mid - right) * (mid - right - 1) / 2) : (mid * (mid - 1) / 2);
            total += rightSum;
        }

        if (total <= maxSum) {
            low = mid;
        } else {
            high = mid - 1;
        }
    }

    return low;
}