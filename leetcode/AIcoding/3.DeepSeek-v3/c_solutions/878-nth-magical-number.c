int nthMagicalNumber(int n, int a, int b) {
    long long mod = 1000000007;
    long long lcm = (long long)a * b / gcd(a, b);
    long long left = 1, right = 1e18;

    while (left < right) {
        long long mid = left + (right - left) / 2;
        long long count = mid / a + mid / b - mid / lcm;

        if (count < n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left % mod;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}