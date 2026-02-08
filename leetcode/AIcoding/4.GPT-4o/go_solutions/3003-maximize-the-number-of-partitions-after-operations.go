func maximizePartitions(n int, k int, A []int) int {
    sort.Ints(A)
    count := 0
    for i := len(A) - 1; i >= 0; i-- {
        if A[i] >= k {
            count++
        } else {
            break
        }
    }
    return count
}