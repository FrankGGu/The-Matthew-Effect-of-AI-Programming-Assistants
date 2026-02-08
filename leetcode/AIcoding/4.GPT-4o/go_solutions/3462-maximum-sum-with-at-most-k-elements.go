func maxSum(K int, A []int) int {
    n := len(A)
    if n == 0 || K == 0 {
        return 0
    }

    sort.Ints(A)
    sum := 0
    for i := n - K; i < n; i++ {
        sum += A[i]
    }

    return sum
}