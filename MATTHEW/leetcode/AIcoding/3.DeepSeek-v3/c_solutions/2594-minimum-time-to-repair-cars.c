int cmp(const void* a, const void* b) {
    return *(long long*)a - *(long long*)b;
}

long long repairCars(int* ranks, int ranksSize, int cars) {
    long long left = 1;
    long long right = 1LL * ranks[0] * cars * cars;

    while (left < right) {
        long long mid = left + (right - left) / 2;
        long long total = 0;

        for (int i = 0; i < ranksSize; i++) {
            total += (long long)sqrt(mid / ranks[i]);
        }

        if (total >= cars) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}