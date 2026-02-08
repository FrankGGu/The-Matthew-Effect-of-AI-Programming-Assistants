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

    for i := 1; i < len(restrictions); i++ {
        restrictions[i][1] = min(restrictions[i][1], restrictions[i-1][1] + restrictions[i][0] - restrictions[i-1][0])
    }

    for i := len(restrictions)-2; i >= 0; i-- {
        restrictions[i][1] = min(restrictions[i][1], restrictions[i+1][1] + restrictions[i+1][0] - restrictions[i][0])
    }

    maxHeight := 0
    for i := 1; i < len(restrictions); i++ {
        left, right := restrictions[i-1][0], restrictions[i][0]
        leftH, rightH := restrictions[i-1][1], restrictions[i][1]
        maxHeight = max(maxHeight, (leftH + rightH + right - left) / 2)
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