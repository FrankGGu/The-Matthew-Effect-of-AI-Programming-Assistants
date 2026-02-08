long long calculate_gcd(long long x, long long y) {
    while (y) {
        long long temp = y;
        y = x % y;
        x = temp;
    }
    return x;
}

long long calculate_lcm(long long x, long long y) {
    return (x / calculate_gcd(x, y)) * y;
}

int nthMagicalNumber(int n, int a, int b) {
    long long N = n;
    long long A = a;
    long long B = b;

    long long common_lcm = calculate_lcm(A, B);

    long long low = 0;
    long long high = N * (A > B ? A : B);

    long long ans = high;

    long long MOD = 1000000007;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long count_val = (mid / A) + (mid / B) - (mid / common_lcm);

        if (count_val >= N) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return (int)(ans % MOD);
}