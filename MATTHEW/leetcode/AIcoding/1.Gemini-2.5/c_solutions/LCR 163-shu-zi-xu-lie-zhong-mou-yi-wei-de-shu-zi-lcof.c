int findKthDigit(int k_int) {
    long long k = k_int;
    long long digits = 1;
    long long count = 9;
    long long start = 1;

    while (k > digits * count) {
        k -= digits * count;
        digits++;
        count *= 10;
        start *= 10;
    }

    long long num = start + (k - 1) / digits;
    long long idx = (k - 1) % digits;

    long long divisor = 1;
    for (int i = 0; i < digits - 1 - idx; ++i) {
        divisor *= 10;
    }

    return (int)((num / divisor) % 10);
}