type Node struct {
    Val      int
    Neighbors []*Node
}

func maxScore(nodes []*Node) int {
    n := len(nodes)
    score := make([]int, n)
    for i := 0; i < n; i++ {
        score[i] = nodes[i].Val
    }

    maxScore := 0
    for i := 0; i < n; i++ {
        for _, neighbor := range nodes[i].Neighbors {
            maxScore = max(maxScore, score[i]+neighbor.Val)
        }
    }

    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}