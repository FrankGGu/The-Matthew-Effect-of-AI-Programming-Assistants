func minKBitFlips(A []int, K int) int {
    n := len(A)
    flip := 0
    res := 0
    flipCount := make([]int, n+1)

    for i := 0; i < n; i++ {
        flip += flipCount[i]
        if (A[i]+flip)%2 == 0 {
            if i+K > n {
                return -1
            }
            res++
            flip++
            if i+K < n {
                flipCount[i+K]--
            }
        }
    }
    return res
}