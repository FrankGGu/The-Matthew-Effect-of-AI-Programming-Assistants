int numDupDigitsAtMostN(int n) {
    int digits[10];
    int len = 0;
    int temp = n + 1;
    while (temp > 0) {
        digits[len++] = temp % 10;
        temp /= 10;
    }
    for (int i = 0; i < len / 2; i++) {
        int t = digits[i];
        digits[i] = digits[len - 1 - i];
        digits[len - 1 - i] = t;
    }

    int res = 0;
    for (int i = 1; i < len; i++) {
        res += 9 * perm(9, i - 1);
    }

    int used[10] = {0};
    for (int i = 0; i < len; i++) {
        for (int j = (i == 0 ? 1 : 0); j < digits[i]; j++) {
            if (used[j]) continue;
            res += perm(9 - i, len - i - 1);
        }
        if (used[digits[i]]) break;
        used[digits[i]] = 1;
    }

    return n - res;
}

int perm(int n, int k) {
    if (k == 0) return 1;
    int res = 1;
    for (int i = 0; i < k; i++) {
        res *= (n - i);
    }
    return res;
}