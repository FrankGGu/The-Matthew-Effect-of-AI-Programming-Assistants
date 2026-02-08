func closetTarget(words []string, target string, startIndex int) int {
    n := len(words)
    minDist := n
    found := false
    for i := 0; i < n; i++ {
        if words[i] == target {
            found = true
            dist := abs(i - startIndex)
            dist = min(dist, n - dist)
            if dist < minDist {
                minDist = dist
            }
        }
    }
    if !found {
        return -1
    }
    return minDist
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}