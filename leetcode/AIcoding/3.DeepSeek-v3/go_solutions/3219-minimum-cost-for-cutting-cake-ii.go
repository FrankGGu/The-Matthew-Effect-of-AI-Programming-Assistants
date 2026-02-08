import "sort"

func minCost(n int, m int, horizontalCuts []int, verticalCuts []int) int {
    sort.Ints(horizontalCuts)
    sort.Ints(verticalCuts)

    maxH := max(horizontalCuts[0], n - horizontalCuts[len(horizontalCuts)-1])
    for i := 1; i < len(horizontalCuts); i++ {
        maxH = max(maxH, horizontalCuts[i] - horizontalCuts[i-1])
    }

    maxV := max(verticalCuts[0], m - verticalCuts[len(verticalCuts)-1])
    for i := 1; i < len(verticalCuts); i++ {
        maxV = max(maxV, verticalCuts[i] - verticalCuts[i-1])
    }

    return (maxH * maxV) % (1e9 + 7)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}