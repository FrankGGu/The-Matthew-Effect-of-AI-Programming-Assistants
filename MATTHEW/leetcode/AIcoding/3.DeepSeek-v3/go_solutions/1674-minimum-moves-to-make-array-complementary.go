func minMoves(nums []int, limit int) int {
    n := len(nums)
    delta := make([]int, 2*limit+2)

    for i := 0; i < n/2; i++ {
        a, b := nums[i], nums[n-1-i]
        left := 2
        right := 2 * limit

        delta[left] += 2
        delta[right+1] -= 2

        left = 1 + min(a, b)
        right = limit + max(a, b)

        delta[left] += -1
        delta[right+1] -= -1

        sum := a + b
        delta[sum] += -1
        delta[sum+1] -= -1
    }

    res := n
    current := 0
    for i := 2; i <= 2*limit; i++ {
        current += delta[i]
        if current < res {
            res = current
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}