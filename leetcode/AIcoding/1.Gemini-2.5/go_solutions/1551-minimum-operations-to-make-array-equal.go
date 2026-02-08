func minOperations(n int) int {
    operations := 0
    // The target value for all elements to become equal is n.
    // We need to sum the differences for elements that are less than n.
    // These elements are arr[i] = 2*i + 1.
    // We iterate for i such that 2*i + 1 < n.
    // This implies 2*i < n - 1, or i < (n - 1) / 2.
    // In integer division, this is equivalent to i < n / 2.
    for i := 0; i < n/2; i++ {
        // The current element is (2*i + 1).
        // The amount needed to reach the target 'n' is n - (2*i + 1).
        operations += n - (2*i + 1)
    }
    return operations
}