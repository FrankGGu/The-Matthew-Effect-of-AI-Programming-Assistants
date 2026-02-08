int countBeautifulNumbers(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        int num = i;
        int firstDigit = 0;
        int lastDigit = num % 10;

        while (num > 0) {
            firstDigit = num % 10;
            num /= 10;
        }

        if (firstDigit == lastDigit) {
            count++;
        }
    }
    return count;
}