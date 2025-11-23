func maximizeSquareArea(m int, n int, hFences []int, vFences []int) int {
    const mod = 1e9 + 7

    hFences = append(hFences, 1, m)
    vFences = append(vFences, 1, n)
    sort.Ints(hFences)
    sort.Ints(vFences)

    hGaps := make(map[int]bool)
    for i := 0; i < len(hFences); i++ {
        for j := i + 1; j < len(hFences); j++ {
            hGaps[hFences[j]-hFences[i]] = true
        }
    }

    maxSide := 0
    for i := 0; i < len(vFences); i++ {
        for j := i + 1; j < len(vFences); j++ {
            gap := vFences[j] - vFences[i]
            if hGaps[gap] && gap > maxSide {
                maxSide = gap
            }
        }
    }

    if maxSide == 0 {
        return -1
    }
    return (maxSide * maxSide) % mod
}