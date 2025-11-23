int countSpecialNumbers(int n) {
    if (n < 10) return n;

    int digits[10];
    int len = 0;
    int temp = n;
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
        int count = 9;
        for (int j = 1; j < i; j++) {
            count *= (10 - j);
        }
        res += count;
    }

    bool used[10] = {false};
    for (int i = 0; i < len; i++) {
        int start = (i == 0) ? 1 : 0;
        for (int d = start; d < digits[i]; d++) {
            if (!used[d]) {
                int count = 1;
                for (int j = i + 1; j < len; j++) {
                    count *= (10 - j);
                }
                res += count;
            }
        }
        if (used[digits[i]]) break;
        used[digits[i]] = true;
        if (i == len - 1) res++;
    }

    return res;
}