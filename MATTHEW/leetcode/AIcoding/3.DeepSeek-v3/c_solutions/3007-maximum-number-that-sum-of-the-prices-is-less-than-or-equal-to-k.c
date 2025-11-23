long long calculateSum(long long n, long long x) {
    long long sum = 0;
    long long bit = 1LL << (x - 1);
    long long block = bit * 2;
    long long full_blocks = n / block;
    sum += full_blocks * bit;
    long long remainder = n % block;
    if (remainder >= bit) {
        sum += remainder - bit + 1;
    }
    return sum;
}

long long findMaximumNumber(long long k, int x) {
    long long left = 1;
    long long right = 1e15;
    long long result = 0;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long total = 0;

        for (int i = 1; i <= 60; i++) {
            if (i % x == 0) {
                total += calculateSum(mid, i);
                if (total > k) break;
            }
        }

        if (total <= k) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}