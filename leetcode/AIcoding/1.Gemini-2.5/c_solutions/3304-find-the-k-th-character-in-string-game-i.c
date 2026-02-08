int kthGrammar(int n, int k) {
    if (n == 1) {
        return 0;
    }

    int mid = 1 << (n - 2); // Represents 2^(n-2), the length of the (n-1)th row, and the midpoint for the nth row.

    if (k <= mid) {
        // If k is in the first half of the current row,
        // it's the same as the k-th character in the previous row.
        return kthGrammar(n - 1, k);
    } else {
        // If k is in the second half of the current row,
        // it's the complement of the (k - mid)-th character in the previous row.
        return 1 - kthGrammar(n - 1, k - mid);
    }
}