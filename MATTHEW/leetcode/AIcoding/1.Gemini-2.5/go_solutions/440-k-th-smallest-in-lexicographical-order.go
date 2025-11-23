func findKthNumber(n int, k int) int {
    current := 1
    k-- // Adjust k to be 0-indexed relative to the current number

    for k > 0 {
        // Calculate the number of elements in the subtree rooted at 'current'
        // and its children, up to 'n'.