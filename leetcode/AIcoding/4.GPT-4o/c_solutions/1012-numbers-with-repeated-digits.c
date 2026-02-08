int numDupDigitsAtMostN(int N) {
    int digits[10], count = 0, temp = N, len = 0;

    while (temp > 0) {
        digits[len++] = temp % 10;
        temp /= 10;
    }

    int res = 0;
    for (int i = 1; i < len; ++i) {
        res += 9 * perm(9, i - 1);
    }

    int seen[10] = {0};
    for (int i = len - 1; i >= 0; --i) {
        for (int j = (i == len - 1 ? 1 : 0); j < digits[i]; ++j) {
            if (!seen[j]) {
                res += perm(9 - i, len - i - 1);
            }
        }
        if (seen[digits[i]]) break;
        seen[digits[i]] = 1;
    }

    return N - res;
}

int perm(int n, int k) {
    int res = 1;
    for (int i = 0; i < k; ++i) {
        res *= (n - i);
    }
    return res;
}