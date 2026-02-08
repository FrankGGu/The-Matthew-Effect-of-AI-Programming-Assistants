func maxBuilding(n int, restrictions [][]int) int {
    if len(restrictions) == 0 {
        return n - 1
    }

    restrictions = append(restrictions, []int{1, 0})
    sort.Slice(restrictions, func(i, j int) bool {
        return restrictions[i][0] < restrictions[j][0]
    })

    if restrictions[len(restrictions)-1][0] != n {
        restrictions = append(restrictions, []int{n, n-1})
    }

    m := len(restrictions)

    for i := 1; i < m; i++ {
        prevPos, prevHeight := restrictions[i-1][0], restrictions[i-1][1]
        currPos, currHeight := restrictions[i][0], restrictions[i][1]
        restrictions[i][1] = min(currHeight, prevHeight + (currPos - prevPos))
    }

    for i := m-2; i >= 0; i-- {
        nextPos, nextHeight := restrictions[i+1][0], restrictions[i+1][1]
        currPos, currHeight := restrictions[i][0], restrictions[i][1]
        restrictions[i][1] = min(currHeight, nextHeight + (nextPos - currPos))
    }

    maxHeight := 0
    for i := 0; i < m-1; i++ {
        pos1, h1 := restrictions[i][0], restrictions[i][1]
        pos2, h2 := restrictions[i+1][0], restrictions[i+1][1]
        maxHeight = max(maxHeight, max(h1, h2) + (pos2 - pos1 - abs(h1 - h2)) / 2)
    }

    return maxHeight
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}