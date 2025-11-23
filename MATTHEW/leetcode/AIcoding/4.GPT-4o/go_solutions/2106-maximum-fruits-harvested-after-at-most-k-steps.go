func maxFruits(fruits []int, k int) int {
    n := len(fruits)
    left, right := 0, 0
    sum, maxFruits := 0, 0

    for right < n {
        sum += fruits[right]
        for (right-left+1) > k+1 {
            sum -= fruits[left]
            left++
        }
        maxFruits = max(maxFruits, sum)
        right++
    }

    return maxFruits
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}