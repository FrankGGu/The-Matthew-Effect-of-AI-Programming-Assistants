int minimumSum(int n, int k) {
    int sum = 0;
    int count = 0;
    for (int i = 1; count < n; i++) {
        if (i % k != 0) {
            sum += i;
            count++;
        }
    }
    return sum;
}