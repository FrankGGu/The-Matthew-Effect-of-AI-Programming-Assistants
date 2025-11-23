func totalFruit(fruits []int) int {
    count := make(map[int]int)
    left, max := 0, 0

    for right, fruit := range fruits {
        count[fruit]++
        for len(count) > 2 {
            leftFruit := fruits[left]
            count[leftFruit]--
            if count[leftFruit] == 0 {
                delete(count, leftFruit)
            }
            left++
        }
        if right-left+1 > max {
            max = right - left + 1
        }
    }
    return max
}