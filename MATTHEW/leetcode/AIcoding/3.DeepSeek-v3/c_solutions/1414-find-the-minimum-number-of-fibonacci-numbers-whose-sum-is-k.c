int findMinFibonacciNumbers(int k) {
    int fib[50];
    fib[0] = 1;
    fib[1] = 1;
    int count = 2;

    while (fib[count - 1] < k) {
        fib[count] = fib[count - 1] + fib[count - 2];
        count++;
    }

    int result = 0;
    int remaining = k;

    for (int i = count - 1; i >= 0 && remaining > 0; i--) {
        if (fib[i] <= remaining) {
            remaining -= fib[i];
            result++;
        }
    }

    return result;
}