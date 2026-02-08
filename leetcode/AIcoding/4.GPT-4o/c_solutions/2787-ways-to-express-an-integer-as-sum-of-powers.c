int countPowers(int n, int x, int curr) {
    if (n == 0) return 1;
    if (n < 0 || curr > n) return 0;
    return countPowers(n - curr, x, curr + 1) + countPowers(n, x, curr + 1);
}

int powerfulIntegers(int x, int y, int bound) {
    int count = 0;
    for (int i = 0; i * i <= bound; ++i) {
        for (int j = 0; j * j <= bound; ++j) {
            int sum = (int)pow(x, i) + (int)pow(y, j);
            if (sum <= bound) {
                count++;
            }
            if (y == 1) break; // If y is 1, stop as further j will give same result
        }
        if (x == 1) break; // If x is 1, stop as further i will give same result
    }
    return count;
}