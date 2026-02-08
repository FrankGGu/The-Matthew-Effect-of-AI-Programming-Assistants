int smallestDivisible(int n) {
    int result = 1;
    for (int i = 2; i <= n; i++) {
        if (n % i == 0) {
            result *= i;
        }
    }
    return result;
}