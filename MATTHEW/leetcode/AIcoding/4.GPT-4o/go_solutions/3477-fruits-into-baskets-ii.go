func totalFruits(fruits []int) int {
    left, right, maxFruits := 0, 0, 0
    count := make(map[int]int)

    for right < len(fruits) {
        count[fruits[right]]++
        for len(count) > 2 {
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