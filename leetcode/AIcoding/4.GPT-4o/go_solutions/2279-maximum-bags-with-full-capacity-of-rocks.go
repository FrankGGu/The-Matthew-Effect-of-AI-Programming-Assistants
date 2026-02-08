func maxBags(capacity []int, rocks []int, additionalRocks int) int {
    n := len(capacity)
    requiredSpace := make([]int, n)

    for i := 0; i < n; i++ {
        requiredSpace[i] = capacity[i] - rocks[i]
    }

    sort.Ints(requiredSpace)

    count := 0
    for _, space := range requiredSpace {
        if additionalRocks >= space {
            additionalRocks -= space
            count++
        } else {
            break
        }
    }

    return count
}