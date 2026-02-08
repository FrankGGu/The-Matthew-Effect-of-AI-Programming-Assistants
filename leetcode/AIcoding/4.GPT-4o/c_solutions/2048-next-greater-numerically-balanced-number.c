int nextGreaterBalanced(int n) {
    long long num = n;
    int digits[10];
    int len = 0;

    while (num > 0) {
        digits[len++] = num % 10;
        num /= 10;
    }

    for (int i = 0; i < len / 2; i++) {
        if (digits[i] != digits[len - i - 1]) {
            return -1;
        }
    }

    for (int i = len - 1; i >= 0; i--) {
        if (digits[i] < 9) {
            digits[i]++;
            for (int j = i + 1; j < len; j++) {
                digits[j] = 0;
            }
            long long result = 0;
            for (int j = len - 1; j >= 0; j--) {
                result = result * 10 + digits[j];
            }
            return result;
        }
    }

    return -1;
}