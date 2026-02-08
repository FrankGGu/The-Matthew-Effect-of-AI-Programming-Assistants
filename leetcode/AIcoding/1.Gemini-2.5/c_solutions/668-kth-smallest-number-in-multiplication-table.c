int count_less_equal(int val, int m, int n) {
    int count = 0;
    for (int i = 1; i <= m; ++i) {
        // For row i, numbers are i*1, i*2, ..., i*n.
        // We want to count j such that i*j <= val, which means j <= val/i.
        // The maximum possible j is n.
        // So, the number of elements in row i less than or equal to val is min(n, val / i).
        count += (val / i < n) ? (val / i) : n;
    }
    return count;
}

int findKthNumber(int m, int n, int k) {
    int low = 1;
    int high = m * n;
    int ans = m * n; 

    while (low <= high) {
        int mid = low + (high - low) / 2;
        int count = count_less_equal(mid, m, n);

        if (count >= k) {
            // mid could be the Kth smallest number, or a larger number.
            // We try to find a smaller candidate.
            ans = mid;
            high = mid - 1;
        } else {
            // mid is too small, we need a larger number.
            low = mid + 1;
        }
    }
    return ans;
}