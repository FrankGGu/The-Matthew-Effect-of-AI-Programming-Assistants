int monotoneIncreasingDigits(int n) {
    if (n < 10) return n;

    char digits[11];
    sprintf(digits, "%d", n);
    int len = strlen(digits);

    int i;
    for (i = len - 1; i > 0; i--) {
        if (digits[i] < digits[i - 1]) {
            digits[i - 1]--;
            for (int j = i; j < len; j++) {
                digits[j] = '9';
            }
        }
    }

    return atoi(digits);
}