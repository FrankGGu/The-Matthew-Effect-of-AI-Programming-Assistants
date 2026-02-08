func maxFruits(fruits []int, n int) int {
    left, right := 0, 0
    count := make(map[int]int)
    maxFruits := 0

    for right < len(fruits) {
        count[fruits[right]]++
        for len(count) > n {
            count[fruits[left]]--
            if count[fruits[left]] == 0 {
                delete(count, fruits[left])
            }
            left++
        }
        maxFruits = max(maxFruits, right-left+1)
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