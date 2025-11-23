func countHighestScoreNodes(parents []int) int {
    n := len(parents)
    children := make([][]int, n)
    for i := 1; i < n; i++ {
        p := parents[i]
        children[p] = append(children[p], i)
    }

    maxScore := 0
    count := 0

    var dfs func(int) int
    dfs = func(node int) int {
        size := 1
        score := 1
        for _, child := range children[node] {
            childSize := dfs(child)
            size += childSize
            score *= childSize
        }
        if node != 0 {
            score *= (n - size)
        }
        if score > maxScore {
            maxScore = score
            count = 1
        } else if score == maxScore {
            count++
        }
        return size
    }
    dfs(0)
    return count
}