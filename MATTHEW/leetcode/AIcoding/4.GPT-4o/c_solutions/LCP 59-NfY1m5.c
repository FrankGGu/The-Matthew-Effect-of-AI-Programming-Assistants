int minDays(int n) {
    if (n == 0) return 0;
    return (n % 2) + minDays(n / 2) + 1;
}