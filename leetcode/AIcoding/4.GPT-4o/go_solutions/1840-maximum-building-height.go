func maxBuilding(n int, restrictions [][]int) int {
    restrictions = append(restrictions, []int{0, 0}, []int{n, n})
    sort.Slice(restrictions, func(i, j int) bool {
        return restrictions[i][0] < restrictions[j][0]
    })

    for i := 1; i < len(restrictions); i++ {
        dx := restrictions[i][0] - restrictions[i-1][0]
        restrictions[i][1] = max(restrictions[i][1], restrictions[i-1][1]+dx)
    }

    for i := len(restrictions) - 2; i >= 0; i-- {
        dx := restrictions[i+1][0] - restrictions[i][0]
        restrictions[i][1] = max(restrictions[i][1], restrictions[i+1][1]-dx)
    }

    maxHeight := 0
    for i := 1; i < len(restrictions); i++ {
        dx := restrictions[i][0] - restrictions[i-1][0]
        h1 := restrictions[i-1][1]
        h2 := restrictions[i][1]
        maxHeight = max(maxHeight, (h1+h2+dx)/2)
    }

    return maxHeight
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}