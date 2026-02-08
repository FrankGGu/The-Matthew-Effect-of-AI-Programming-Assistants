int minDays(int n) {
    if (n == 0) return 0;
    return 1 + (n % 2) + minDays(n / 3);
}