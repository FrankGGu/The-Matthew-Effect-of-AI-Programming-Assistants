int countKReducibleNumbers(int n, int k) {
    int count = 0;
    for (int i = 1; i < n; i++) {
        int temp = i;
        int digits = 0;
        while (temp > 0) {
            digits++;
            temp /= 10;
        }
        if (digits <= k) {
            count++;
        }
    }
    return count;
}