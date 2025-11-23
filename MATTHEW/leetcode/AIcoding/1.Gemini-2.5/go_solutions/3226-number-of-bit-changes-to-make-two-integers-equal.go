func minChanges(n int, k int) int {
    if k > n {
        return -1
    }

    changes := 0
    for i := 0; i < 31; i++ { // Iterate through bits from 0 to 30 (since n, k <= 10^9, which is less