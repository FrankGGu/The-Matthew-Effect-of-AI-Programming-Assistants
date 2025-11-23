int countSymmetricIntegers(int low, int high) {
    int count = 0;

    for (int i = low; i <= high; i++) {
        int sum1 = 0, sum2 = 0, num = i;
        int digits = 0;

        while (num > 0) {
            digits++;
            num /= 10;
        }

        num = i;
        for (int j = 0; j < (digits + 1) / 2; j++) {
            sum1 += num % 10;
            num /= 10;
        }

        for (int j = 0; j < digits / 2; j++) {
            sum2 += num % 10;
            num /= 10;
        }

        if (sum1 == sum2) {
            count++;
        }
    }

    return count;
}