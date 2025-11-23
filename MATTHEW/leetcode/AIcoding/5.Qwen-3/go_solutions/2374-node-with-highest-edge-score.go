package main

func mostVisitedEdge(n int, edges []int) int {
    score := make([]int, n)
    for i := 0; i < len(edges); i++ {
        score[edges[i]]++
    }
    maxScore := -1
    result := 0
    for i := 0; i < n; i++ {
        if score[i] > maxScore {
            maxScore = score[i]
            result = i
        }
    }
    return result
}