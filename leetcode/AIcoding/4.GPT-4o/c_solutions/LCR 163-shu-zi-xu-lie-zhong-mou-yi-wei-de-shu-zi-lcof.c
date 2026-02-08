int findKthDigit(int n, int k) {
    long long count = 9, len = 1, start = 1;
    while (k > len * count) {
        k -= len * count;
        len++;
        count *= 10;
        start *= 10;
    }
    start += (k - 1) / len;
    char digit = (start / (long long)pow(10, len - 1 - (k - 1) % len)) % 10 + '0';
    return digit - '0';
}