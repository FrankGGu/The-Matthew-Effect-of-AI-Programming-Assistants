int canCompletePlan(int n, int m, int k, int* a) {
    int total = 0;
    for (int i = 0; i < n; i++) {
        total += a[i];
    }
    return (total >= m && total <= m + k) ? 1 : 0;
}