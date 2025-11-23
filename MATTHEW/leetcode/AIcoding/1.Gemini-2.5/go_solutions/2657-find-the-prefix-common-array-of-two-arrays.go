func findThePrefixCommonArray(A []int, B []int) []int {
    n := len(A)
    ans := make([]int, n)

    seenA := make([]bool, n+1)
    seenB := make([]bool, n+1)

    commonCount := 0

    for k := 0; k < n; k++ {
        valA := A[k]
        valB := B[k]

        if !seenA[valA] {
            seenA[valA] = true
            if seenB[valA] {
                commonCount++
            }
        }

        if !seenB[valB] {
            seenB[valB] = true
            if seenA[valB] {
                commonCount++
            }
        }

        ans[k] = commonCount
    }

    return ans
}