func longestMountain(A []int) int {
    n := len(A)
    longest := 0

    for i := 1; i < n-1; i++ {
        if A[i] > A[i-1] && A[i] > A[i+1] {
            left, right := i, i
            for left > 0 && A[left-1] < A[left] {
                left--
            }
            for right < n-1 && A[right+1] < A[right] {
                right++
            }
            longest = max(longest, right-left+1)
        }
    }

    return longest
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}