int countBeautifulNumbers(int low, int high) {
    int count = 0;
    for (int i = low; i <= high; i++) {
        int num = i, digitSum = 0, digitProd = 1;
        while (num > 0) {
            int digit = num % 10;
            digitSum += digit;
            digitProd *= digit ? digit : 1;
            num /= 10;
        }
        if (digitSum == digitProd) {
            count++;
        }
    }
    return count;
}