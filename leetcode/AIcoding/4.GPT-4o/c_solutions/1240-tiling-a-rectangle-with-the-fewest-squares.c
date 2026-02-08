int minCount(int n, int m) {
    if (n == m) return 1;
    if (n < m) return minCount(m, n);
    int count = n / m + (n % m ? minCount(n % m, m) : 0);
    return count;
}

int tilingRectangle(int n, int m) {
    return minCount(n, m);
}