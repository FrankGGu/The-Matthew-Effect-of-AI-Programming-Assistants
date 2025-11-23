int repairCars(int* ranks, int ranksSize, int cars) {
    int left = 1, right = INT_MAX, result = INT_MAX;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long total = 0;

        for (int i = 0; i < ranksSize; i++) {
            total += (long long)(sqrt(mid / ranks[i]));
            if (total >= cars) break;
        }

        if (total >= cars) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
}