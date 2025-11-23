func minLevels(energy int, tasks [][]int) int {
    n := len(tasks)
    sort.Slice(tasks, func(i, j int) bool {
        return tasks[i][1]-tasks[i][0] > tasks[j][1]-tasks[j][0]
    })

    count := 0
    for i := 0; i < n; i++ {
        if energy >= tasks[i][1] {
            energy -= tasks[i][0]
            count++
        }
    }

    if count == n {
        return 0
    }

    energy = 0
    dp := make([]int, energy + 1)

    for i := 0; i <= energy; i++ {
        dp[i] = -1
    }
    dp[0] = 0

    for i := 0; i < n; i++ {
        if energy < tasks[i][1] {
            energy = tasks[i][1]
        }
    }

    dp = make([]int, energy + 1)
    for i := 0; i <= energy; i++ {
        dp[i] = -1
    }
    dp[0] = 0

    for i := 0; i < n; i++ {
        for j := energy; j >= tasks[i][1]; j-- {
            if dp[j-tasks[i][0]] != -1 {
                dp[j] = max(dp[j], dp[j-tasks[i][0]]+1)
            }
        }
    }

    ans := n
    for i := 0; i <= energy; i++ {
        if dp[i] != -1 {
            ans = min(ans, n-dp[i])
        }
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}