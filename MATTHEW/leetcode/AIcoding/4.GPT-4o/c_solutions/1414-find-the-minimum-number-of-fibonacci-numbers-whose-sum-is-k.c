int findMinFibonacciNumbers(int k) {
    int fib[30] = {0, 1};
    for (int i = 2; i < 30; i++) {
        fib[i] = fib[i - 1] + fib[i - 2];
    }
    int count = 0;
    for (int i = 29; i >= 0 && k > 0; i--) {
        if (fib[i] <= k) {
            k -= fib[i];
            count++;
        }
    }
    return count;
}