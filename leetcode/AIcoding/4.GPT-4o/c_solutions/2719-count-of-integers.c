int countIntegers(int low, int high) {
    int count = 0;
    for (int i = low; i <= high; i++) {
        int n = i, sum = 0;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        if (sum % 2 == 0) {
            count++;
        }
    }
    return count;
}