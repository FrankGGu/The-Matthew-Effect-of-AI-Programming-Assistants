func maxCount(banned []int, n int, maxSum int) int {
    bannedSet := make(map[int]bool)
    for _, num := range banned {
        bannedSet[num] = true
    }

    sum := 0
    count := 0

    for i := 1; i <= n; i++ {
        if !bannedSet[i] {
            if sum + i > maxSum {
                break
            }
            sum += i
            count++
        }
    }

    return count
}