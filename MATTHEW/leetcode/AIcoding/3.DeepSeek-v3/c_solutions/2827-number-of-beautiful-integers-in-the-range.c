int numberOfBeautifulIntegers(int low, int high, int k) {
    int count = 0;
    for (int num = low; num <= high; num++) {
        int temp = num;
        int even = 0, odd = 0;
        while (temp > 0) {
            int digit = temp % 10;
            if (digit % 2 == 0) {
                even++;
            } else {
                odd++;
            }
            temp /= 10;
        }
        if (even == odd && num % k == 0) {
            count++;
        }
    }
    return count;
}