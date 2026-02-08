int countNonSpecialNumbers(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        int num = i;
        int digits[10] = {0};
        int isSpecial = 1;

        while (num > 0) {
            int digit = num % 10;
            if (digits[digit]) {
                isSpecial = 0;
                break;
            }
            digits[digit] = 1;
            num /= 10;
        }

        if (!isSpecial) {
            count++;
        }
    }
    return n - count;
}