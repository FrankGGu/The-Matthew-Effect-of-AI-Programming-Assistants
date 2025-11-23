int maxDays(int A[], int n) {
    int left = 0, right = 0, max_days = 0;
    for (int i = 0; i < n; i++) {
        if (A[i] == 0) {
            left = right;
            right = i + 1;
            max_days = fmax(max_days, right - left);
        }
    }
    return fmax(max_days, n - left);
}