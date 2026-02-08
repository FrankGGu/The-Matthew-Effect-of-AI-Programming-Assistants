func minSwap(A []int, B []int) int {
    n := len(A)
    swap := make([]int, n)
    noSwap := make([]int, n)
    for i := 0; i < n; i++ {
        swap[i] = n
        noSwap[i] = n
    }
    noSwap[0] = 0
    swap[0] = 1

    for i := 1; i < n; i++ {
        if A[i] > A[i-1] && B[i] > B[i-1] {
            noSwap[i] = noSwap[i-1]
            swap[i] = swap[i-1] + 1
        }
        if A[i] > B[i-1] && B[i] > A[i-1] {
            noSwap[i] = min(noSwap[i], swap[i-1])
            swap[i] = min(swap[i], noSwap[i-1] + 1)
        }
    }
    return min(swap[n-1], noSwap[n-1])
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}