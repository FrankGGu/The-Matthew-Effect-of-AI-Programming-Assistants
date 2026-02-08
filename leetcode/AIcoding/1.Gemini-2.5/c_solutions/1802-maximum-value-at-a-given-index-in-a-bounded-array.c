long long calculate_side_sum(long long peak_val, long long length) {
    if (length == 0) {
        return 0;
    }

    if (peak_val - 1 >= length) {
        return (length * (2 * peak_val - 1 - length)) / 2;
    } else {
        return (peak_val * (peak_val - 1)) / 2 + (length - (peak_val - 1));
    }
}

int maxValue(int n, int index, int maxSum) {
    long long low = 1;
    long long high = maxSum;
    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;

        long long left_len = index;
        long long right_len = n - 1 - index;

        long long current_total_sum = mid;

        current_total_sum += calculate_side_sum(mid, left_len);
        current_total_sum += calculate_side_sum(mid, right_len);

        if (current_total_sum <= maxSum) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return (int)ans;
}