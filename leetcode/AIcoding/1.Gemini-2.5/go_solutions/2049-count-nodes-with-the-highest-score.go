package main

func countHighestScoreNodes(parents []int) int {
    n := len(parents)

    children := make([][]int, n)
    for i := 1; i < n; i++ {
        children[parents[i]] = append(children[parents[i]], i)
    }

    subtreeSize := make([]int, n)

    var dfsSubtreeSize func(node int) int
    dfsSubtreeSize = func(node int) int {
        size := 1 
        for _, child := range children[node] {
            size += dfsSubtreeSize(child)
        }
        subtreeSize[node] = size
        return size
    }

    dfsSubtreeSize(0) 

    var maxScore int64 = 0
    count := 0

    for i := 0; i < n; i++ {
        var currentScore int64 = 1

        parentComponentSize := n - subtreeSize[i]
        if parentComponentSize > 0 {
            currentScore *= int64(parentComponentSize)
        }

        for _, child := range children[i] {
            currentScore *= int64(subtreeSize[child])
        }

        if currentScore > maxScore {
            maxScore = currentScore
            count = 1
        } else if currentScore == maxScore {
            count++
        }
    }

    return count
}