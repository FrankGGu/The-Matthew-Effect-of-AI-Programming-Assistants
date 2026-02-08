func findLongestChain(pairs [][]int) int {
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][1] < pairs[j][1]
    })

    maxLength := 0
    currentEnd := math.MinInt64

    for _, pair := range pairs {
        if pair[0] > currentEnd {
            maxLength++
            currentEnd = pair[1]
        }
    }

    return maxLength
}