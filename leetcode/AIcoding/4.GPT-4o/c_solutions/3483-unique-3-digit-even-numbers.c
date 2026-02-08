int uniqueEvenDigitNumbers(int* digits, int digitsSize) {
    int count = 0;
    int used[10] = {0};
    int results[1000] = {0};

    for (int i = 0; i < digitsSize; i++) {
        if (digits[i] % 2 == 0) {
            used[digits[i]] = 1;
        }
    }

    for (int i = 100; i < 1000; i++) {
        int num = i;
        int tempUsed[10] = {0};
        int evenDigit = 0;
        int valid = 1;

        while (num > 0) {
            int digit = num % 10;
            if (tempUsed[digit] || !used[digit]) {
                valid = 0;
                break;
            }
            tempUsed[digit] = 1;
            num /= 10;
        }

        if (valid && (i % 2 == 0)) {
            results[count++] = i;
        }
    }

    return count;
}