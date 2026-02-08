long long coloredCells(int n) {
    if (n == 1) {
        return 1;
    }
    return 1LL + 2LL * n * (n - 1);
}