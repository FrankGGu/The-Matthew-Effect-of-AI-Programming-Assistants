long long trailingZeroes(long long n) {
    long long count = 0;
    while (n > 0) {
        n /= 5;
        count += n;
    }
    return count;
}

int preimageSizeFZF(int k) {
    long long left = 0, right = 5LL * (k + 1);
    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long zeros = trailingZeroes(mid);
        if (zeros == k) {
            return 5;
        } else if (zeros < k) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return 0;
}