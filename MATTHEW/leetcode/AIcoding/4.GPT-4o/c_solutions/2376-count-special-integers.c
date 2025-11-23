int countSpecialNumbers(int n) {
    if (n < 10) return n;

    int digits = 0, temp = n;
    while (temp > 0) {
        digits++;
        temp /= 10;
    }

    int count = 0;
    for (int i = 1; i < digits; i++) {
        count += 9 * permutation(9, i - 1);
    }

    int used[10] = {0};
    for (int i = 0; i < digits; i++) {
        int currentDigit = n / (int)pow(10, digits - i - 1) % 10;
        for (int j = (i == 0) ? 1 : 0; j < currentDigit; j++) {
            if (!used[j]) {
                count += permutation(9 - i, digits - i - 1);
            }
        }
        if (used[currentDigit]) break;
        used[currentDigit] = 1;
    }

    return count + 1;
}

int permutation(int n, int k) {
    if (k == 0) return 1;
    int res = 1;
    for (int i = 0; i < k; i++) {
        res *= (n - i);
    }
    return res;
}