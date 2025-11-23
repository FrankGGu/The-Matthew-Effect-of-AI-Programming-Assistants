func findLongestChain(pairs [][]int) int {
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][1] < pairs[j][1]
    })

    res := 1
    prev := pairs[0][1]

    for i := 1; i < len(pairs); i++ {
        if pairs[i][0] > prev {
            res++
            prev = pairs[i][1]
        }
    }

    return res
}