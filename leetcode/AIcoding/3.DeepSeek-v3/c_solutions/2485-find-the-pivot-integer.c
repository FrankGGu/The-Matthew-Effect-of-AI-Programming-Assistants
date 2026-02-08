int pivotInteger(int n) {
    int total = n * (n + 1) / 2;
    int left_sum = 0;

    for (int x = 1; x <= n; x++) {
        left_sum += x;
        if (left_sum == total - left_sum + x) {
            return x;
        }
    }

    return -1;
}