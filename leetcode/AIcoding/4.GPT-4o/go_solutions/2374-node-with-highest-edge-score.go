func highestEdgeScore(edges []int) int {
    n := len(edges)
    score := make([]int64, n)

    for i, v := range edges {
        score[v] += int64(i)
    }

    maxScore := int64(-1)
    result := -1
    for i, s := range score {
        if s > maxScore {
            maxScore = s
            result = i
        }
    }

    return result
}