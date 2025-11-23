func edgeScore(edges []int) int {
    scores := make(map[int]int)
    maxScore := -1
    result := -1

    for i, node := range edges {
        scores[node] += i
        if scores[node] > maxScore || (scores[node] == maxScore && node < result) {
            maxScore = scores[node]
            result = node
        }
    }

    return result
}