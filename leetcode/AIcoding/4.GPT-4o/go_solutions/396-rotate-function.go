func maxRotateFunction(A []int) int {
    n := len(A)
    sum, F := 0, 0

    for i, v := range A {
        sum += v
        F += i * v
    }

    maxF := F
    for i := 1; i < n; i++ {
        F = F + sum - n * A[n-i]
        if F > maxF {
            maxF = F
        }
    }

    return maxF
}