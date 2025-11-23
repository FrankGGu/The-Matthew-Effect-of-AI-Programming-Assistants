int countDigitOne(int n) {
    if (n <= 0) return 0;
    long long count = 0;
    long long factor = 1;
    while (n / factor > 0) {
        long long lower = n - (n / factor) * factor;
        long long curr = (n / factor) % 10;
        long long higher = n / (factor * 10);

        if (curr == 0) {
            count += higher * factor;
        } else if (curr == 1) {
            count += higher * factor + lower + 1;
        } else {
            count += (higher + 1) * factor;
        }
        factor *= 10;
    }
    return count;
}