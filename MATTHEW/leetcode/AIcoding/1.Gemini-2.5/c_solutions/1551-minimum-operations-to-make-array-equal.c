long long minOperations(int n) {
    long long half_n = n / 2;
    if (n % 2 == 0) {
        return half_n * half_n;
    } else {
        return half_n * (half_n + 1);
    }
}