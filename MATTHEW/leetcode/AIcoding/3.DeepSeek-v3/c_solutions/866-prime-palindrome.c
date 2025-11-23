int primePalindrome(int n) {
    if (n <= 2) return 2;
    if (n <= 3) return 3;
    if (n <= 5) return 5;
    if (n <= 7) return 7;
    if (n <= 11) return 11;

    for (int l = 1; l < 6; l++) {
        int left = pow(10, l - 1);
        int right = pow(10, l) - 1;

        for (int root = left; root <= right; root++) {
            int pal = root;
            int x = root / 10;
            while (x > 0) {
                pal = pal * 10 + (x % 10);
                x /= 10;
            }

            if (pal < n) continue;

            if (isPrime(pal)) {
                return pal;
            }
        }

        for (int root = left; root <= right; root++) {
            int pal = root;
            int x = root;
            while (x > 0) {
                pal = pal * 10 + (x % 10);
                x /= 10;
            }

            if (pal < n) continue;

            if (isPrime(pal)) {
                return pal;
            }
        }
    }

    return -1;
}

int isPrime(int n) {
    if (n < 2) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;

    for (int i = 3; i * i <= n; i += 2) {
        if (n % i == 0) return 0;
    }
    return 1;
}