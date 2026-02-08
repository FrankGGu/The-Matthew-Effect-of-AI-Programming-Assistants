int countNumbersWithNonDecreasingDigits(int n) {
    if (n < 10) return n + 1;

    int count = 0;
    int digits = 0;
    int temp = n;

    while (temp > 0) {
        temp /= 10;
        digits++;
    }

    for (int i = 1; i < digits; i++) {
        count += 9 * comb(9, i);
    }

    int previous = 10;
    for (int i = digits - 1; i >= 0; i--) {
        int current = n / (int)pow(10, i) % 10;

        for (int j = (i == digits - 1 ? 1 : 0); j < current; j++) {
            if (j >= previous) {
                count += comb(9 - j + (i - 1), i - 1);
            }
        }

        if (current < previous) break;
        previous = current;
    }

    return count + 1;
}

int comb(int n, int k) {
    if (k > n) return 0;
    if (k == 0 || k == n) return 1;
    if (k > n - k) k = n - k;
    long long res = 1;
    for (int i = 0; i < k; i++) {
        res = res * (n - i) / (i + 1);
    }
    return (int)res;
}