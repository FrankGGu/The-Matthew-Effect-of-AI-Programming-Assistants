func getSmallestString(n int, k int) string {
    ans := make([]byte, n)

    // k is the sum of character values (a=1, b=2, ..., z=26)
    // To make the string lexicographically smallest, we want 'a's as much as possible at the