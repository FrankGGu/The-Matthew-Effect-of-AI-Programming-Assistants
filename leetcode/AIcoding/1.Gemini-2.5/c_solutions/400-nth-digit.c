int findNthDigit(int n) {
    long long digits = 1;
    long long count = 9;
    long long powerOf10 = 1;

    long long N = n;

    while (N > digits * count) {
        N -= digits * count;
        digits++;
        count *= 10;
        powerOf10 *= 10;
    }

    long long num_offset = (N - 1) / digits;
    long long target_number = powerOf10 + num_offset;

    long long digit_offset = (N - 1) % digits;

    long long divisor = 1;
    for (int i = 0; i < (digits - 1 - digit_offset); i++) {
        divisor *= 10;
    }

    return (int)((target_number / divisor) % 10);
}