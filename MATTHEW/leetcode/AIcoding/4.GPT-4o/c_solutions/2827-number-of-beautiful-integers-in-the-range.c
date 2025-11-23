int countBeautifulIntegers(int low, int high) {
    int count = 0;

    for (int i = low; i <= high; i++) {
        int num = i;
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        if (sum % 2 == 0 && sum >= 2 && sum <= 10) {
            count++;
        }
    }

    return count;
}