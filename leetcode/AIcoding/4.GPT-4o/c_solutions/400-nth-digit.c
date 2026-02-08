int findNthDigit(int n) {
    long long base = 1;
    int digits = 1;
    long long count = 9;

    while (n > digits * count) {
        n -= digits * count;
        digits++;
        base *= 10;
        count *= 10;
    }

    long long num = base + (n - 1) / digits;
    char digit = (num / (long long)pow(10, digits - 1 - (n - 1) % digits)) % 10;

    return digit;
}