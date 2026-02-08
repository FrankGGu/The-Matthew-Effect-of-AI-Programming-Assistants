int maxRunTime(int n, int batteriesSize, int* batteries) {
    long long totalPower = 0;
    for (int i = 0; i < batteriesSize; i++) {
        totalPower += batteries[i];
    }

    long long left = 1, right = totalPower / n;
    while (left < right) {
        long long mid = left + (right - left + 1) / 2;
        long long requiredPower = mid * n;
        if (requiredPower <= totalPower) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}