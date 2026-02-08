package main

func removeFencesAndFindMaximumSquare(area []int, left []int, right []int) int {
    n := len(left)
    m := len(right)
    all := make([]int, 0, n+m)
    for i := 0; i < n; i++ {
        all = append(all, left[i])
    }
    for i := 0; i < m; i++ {
        all = append(all, right[i])
    }
    all = append(all, 0, area[0])
    sort.Ints(all)
    unique := make([]int, 0)
    prev := -1
    for _, v := range all {
        if v != prev {
            unique = append(unique, v)
            prev = v
        }
    }
    pos := make(map[int]int)
    for i, v := range unique {
        pos[v] = i
    }
    size := len(unique)
    dp := make([][]int, size)
    for i := range dp {
        dp[i] = make([]int, size)
    }
    for i := 0; i < size; i++ {
        dp[i][i] = 1
    }
    for length := 2; length <= size; length++ {
        for i := 0; i+length-1 < size; i++ {
            j := i + length - 1
            if unique[j]-unique[i] >= 1 {
                dp[i][j] = 1
            } else {
                dp[i][j] = 0
            }
            for k := i; k < j; k++ {
                if dp[i][k] > 0 && dp[k+1][j] > 0 {
                    dp[i][j] = max(dp[i][j], dp[i][k]+dp[k+1][j])
                }
            }
        }
    }
    maxSide := 0
    for i := 0; i < size; i++ {
        for j := i; j < size; j++ {
            side := unique[j] - unique[i]
            if dp[i][j] >= 2 && side >= 1 {
                maxSide = max(maxSide, side)
            }
        }
    }
    return maxSide * maxSide
}