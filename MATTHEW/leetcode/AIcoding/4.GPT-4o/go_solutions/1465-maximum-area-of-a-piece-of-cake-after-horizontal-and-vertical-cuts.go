func maxArea(h int, w int, horizontalCuts []int, verticalCuts []int) int {
    const mod int = 1e9 + 7
    horizontalCuts = append(horizontalCuts, 0, h)
    verticalCuts = append(verticalCuts, 0, w)

    sort.Ints(horizontalCuts)
    sort.Ints(verticalCuts)

    maxH, maxW := 0, 0

    for i := 1; i < len(horizontalCuts); i++ {
        maxH = max(maxH, horizontalCuts[i]-horizontalCuts[i-1])
    }

    for i := 1; i < len(verticalCuts); i++ {
        maxW = max(maxW, verticalCuts[i]-verticalCuts[i-1])
    }

    return (maxH * maxW) % mod
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}