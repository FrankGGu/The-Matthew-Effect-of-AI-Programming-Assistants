func stoneGameVI(aliceValues []int, bobValues []int) int {
    n := len(aliceValues)
    sums := make([][2]int, n)
    for i := 0; i < n; i++ {
        sums[i] = [2]int{aliceValues[i] + bobValues[i], i}
    }
    sort.Slice(sums, func(i, j int) bool {
        return sums[i][0] > sums[j][0]
    })
    a, b := 0, 0
    for i := 0; i < n; i++ {
        idx := sums[i][1]
        if i%2 == 0 {
            a += aliceValues[idx]
        } else {
            b += bobValues[idx]
        }
    }
    if a > b {
        return 1
    } else if a < b {
        return -1
    }
    return 0
}