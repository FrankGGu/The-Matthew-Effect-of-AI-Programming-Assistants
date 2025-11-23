func maxSumTwoNoOverlap(A []int, L int, M int) int {
    n := len(A)
    maxL, maxM := make([]int, n+1), make([]int, n+1)
    currL, currM := 0, 0
    for i := 1; i <= n; i++ {
        currL += A[i-1]
        if i >= L {
            maxL[i] = max(maxL[i-1], currL)
            currL -= A[i-L]
        }
    }
    currM = 0
    result := 0
    for j := 1; j <= n; j++ {
        currM += A[j-1]
        if j >= M {
            maxM[j] = max(maxM[j-1], currM)
            currM -= A[j-M]
        }
        if j >= L {
            result = max(result, maxM[j]*maxL[j-L])
        }
    }
    currL = 0
    for j := 1; j <= n; j++ {
        currL += A[j-1]
        if j >= L {
            maxL[j] = max(maxL[j-1], currL)
            currL -= A[j-L]
        }
        if j >= M {
            result = max(result, maxL[j-M]*maxM[j])
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}