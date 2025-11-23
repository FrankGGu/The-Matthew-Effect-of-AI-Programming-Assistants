int findMinFibonacciNumbers(int k) {
    int fib[50];
    fib[0] = 1;
    fib[1] = 1;
    int count = 2;

    while (1) {
        int nextFib = fib[count - 1] + fib[count - 2];
        if (nextFib > k) {
            break;
        }
        fib[count] = nextFib;
        count++;
    }

    int ans = 0;
    for (int i = count - 1; i >= 0; i--) {
        if (k >= fib[i]) {
            k -= fib[i];
            ans++;
        }
        if (k == 0) {
            break;
        }
    }

    return ans;
}