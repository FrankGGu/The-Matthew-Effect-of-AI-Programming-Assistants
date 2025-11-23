#define MOD 1000000007

long long gcd(long long a, long long b) {
    while (b) {
        long long t = b;
        b = a % b;
        a = t;
    }
    return a;
}

long long lcm(long long a, long long b) {
    return a / gcd(a, b) * b;
}

int nthMagicalNumber(int n, int a, int b) {
    long long l = lcm(a, b);
    long long left = 0, right = (long long)n * l;
    long long ans = 0;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long count = mid / a + mid / b - mid / l;

        if (count < n) {
            left = mid + 1;
        } else {
            ans = mid;
            right = mid - 1;
        }
    }

    return ans % MOD;
}