package main

func minSpaceWastedToPackBoxes(packageSizes []int, boxes [][]int) int {
    sort.Ints(packageSizes)
    for _, box := range boxes {
        sort.Ints(box)
    }
    n := len(packageSizes)
    m := len(boxes)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = math.MaxInt32
    }
    for i := 0; i < m; i++ {
        box := boxes[i]
        k := len(box)
        for j := n; j >= 0; j-- {
            for l := 0; l < k; l++ {
                if j >= 0 && j-l >= 0 && packageSizes[j-l] <= box[l] {
                    dp[j] = min(dp[j], dp[j-l]+box[l]-packageSizes[j-l])
                } else {
                    break
                }
            }
        }
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}