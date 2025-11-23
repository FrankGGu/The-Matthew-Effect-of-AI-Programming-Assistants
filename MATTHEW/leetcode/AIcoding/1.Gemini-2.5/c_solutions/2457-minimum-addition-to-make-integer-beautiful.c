long long sumDigits(long long num) {
    long long sum = 0;
    while (num > 0) {
        sum += num % 10;
        num /= 10;
    }
    return sum;
}

long long minimumBeautifulNumber(long long n, int target) {
    long long current_n = n;
    long long x = 0;
    long long mod_divisor = 10;

    while (sumDigits(current_n) > target) {
        long long remainder = current_n % mod_divisor;
        long long add_this_step = (mod_divisor - remainder) % mod_divisor;

        x += add_this_step;
        current_n += add_this_step;

        mod_divisor *= 10;
    }

    return x;
}