int minimumTravelTime(int* power, int powerSize, int target) {
    long long total = 0;
    for (int i = 0; i < powerSize; i++) {
        total += power[i];
    }

    long long left = 1, right = total;
    long long ans = right;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        if (canMerge(power, powerSize, target, mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return (int)ans;
}

bool canMerge(int* power, int powerSize, int target, long long maxTime) {
    long long current = 0;
    int segments = 0;

    for (int i = 0; i < powerSize; i++) {
        if (power[i] > maxTime) return false;

        if (current + power[i] <= maxTime) {
            current += power[i];
        } else {
            segments++;
            current = power[i];
        }
    }
    segments++;

    return segments <= target;
}