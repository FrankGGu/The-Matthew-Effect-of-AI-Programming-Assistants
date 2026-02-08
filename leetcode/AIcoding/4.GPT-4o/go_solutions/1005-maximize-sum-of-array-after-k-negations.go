func largestSumAfterKNegations(A []int, K int) int {
    sort.Ints(A)
    for i := 0; i < K; i++ {
        A[0] = -A[0]
        sort.Ints(A)
    }
    sum := 0
    for _, num := range A {
        sum += num
    }
    return sum
}