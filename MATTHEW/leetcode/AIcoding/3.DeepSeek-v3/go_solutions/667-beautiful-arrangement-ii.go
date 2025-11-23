func constructArray(n int, k int) []int {
    res := make([]int, n)
    left, right := 1, n
    for i := 0; i < n; i++ {
        if k > 1 {
            if k%2 == 1 {
                res[i] = left
                left++
            } else {
                res[i] = right
                right--
            }
            k--
        } else {
            res[i] = left
            left++
        }
    }
    return res
}