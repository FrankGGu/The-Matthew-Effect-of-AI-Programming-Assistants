double myPow(double x, int n) {
    if (n == 0) {
        return 1.0;
    }

    if (x == 1.0) {
        return 1.0;
    }
    if (x == -1.0) {
        return (n % 2 == 0) ? 1.0 : -1.0;
    }

    long long N = n;
    double ans = 1.0;

    if (N < 0) {
        x = 1.0 / x;
        N = -N;
    }

    while (N > 0) {
        if (N % 2 == 1) {
            ans *= x;
        }
        x *= x;
        N /= 2;
    }

    return ans;
}