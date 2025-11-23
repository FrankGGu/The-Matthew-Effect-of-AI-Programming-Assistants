int smallestNumber(long long n, int target) {
    if (target == 1) return n == 1 ? 1 : 0;

    long long product = 1;
    long long num = n;
    while (num > 0) {
        product *= (num % 10);
        num /= 10;
    }
    if (product == target) return n;

    char digits[20];
    int len = 0;
    long long temp = n;
    while (temp > 0) {
        digits[len++] = temp % 10;
        temp /= 10;
    }
    for (int i = 0; i < len / 2; i++) {
        char t = digits[i];
        digits[i] = digits[len - 1 - i];
        digits[len - 1 - i] = t;
    }

    for (int i = len - 1; i >= 0; i--) {
        if (digits[i] == 9) continue;
        digits[i]++;
        for (int j = i + 1; j < len; j++) digits[j] = 1;

        long long candidate = 0;
        for (int j = 0; j < len; j++) candidate = candidate * 10 + digits[j];

        long long p = 1;
        temp = candidate;
        while (temp > 0) {
            p *= (temp % 10);
            temp /= 10;
        }
        if (p % target == 0) return candidate;
    }

    len++;
    for (int i = 0; i < len; i++) digits[i] = 1;
    long long candidate = 0;
    for (int i = 0; i < len; i++) candidate = candidate * 10 + digits[i];

    while (1) {
        long long p = 1;
        temp = candidate;
        while (temp > 0) {
            p *= (temp % 10);
            temp /= 10;
        }
        if (p % target == 0) return candidate;
        candidate++;
    }
}