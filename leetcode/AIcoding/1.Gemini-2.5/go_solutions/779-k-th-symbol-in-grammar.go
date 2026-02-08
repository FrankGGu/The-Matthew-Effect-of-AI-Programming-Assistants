func kthGrammar(n int, k int) int {
    if n == 1 {
        return 0
    }

    // Calculate the length of the previous row (n-1),
    // which is also half the length of the current row n.
    // The length of row 'm' is 2^(m-1).
    // So, the length of row 'n-1' is 2^((n-1)-1) = 2^(n-2).
    // This can be calculated efficiently using bit shift: 1 << (n - 2).
    halfLength := 1 << (n - 2)

    if k <= halfLength {
        // If k is in the first half of the current row,
        // its symbol is the same as the symbol at position k in the previous row.
        return kthGrammar(n-1, k)
    } else {
        // If k is in the second half of the current row,
        // its symbol is the inverse of the symbol at position (k - halfLength)
        // in the previous row.
        // We invert the result by subtracting it from 1 (0 becomes 1, 1 becomes 0).
        return 1 - kthGrammar(n-1, k-halfLength)
    }
}