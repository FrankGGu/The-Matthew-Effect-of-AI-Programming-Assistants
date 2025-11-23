package main

func minNumberOfSemesters(n int, relations [][]int) int {
    courseDependencies := make([]int, n)
    for _, relation := range relations {
        courseDependencies[relation[1]-1] |= 1 << (relation[0] - 1)
    }

    memo := make(map[int]int)
    var dfs func(mask int) int
    dfs = func(mask int) int {
        if mask == (1<<n) - 1 {
            return 0
        }
        if val, found := memo[mask]; found {
            return val
        }

        available := 0
        for i := 0; i < n; i++ {
            if (mask & (1 << i)) == 0 && (courseDependencies[i] & mask) == courseDependencies[i] {
                available |= 1 << i
            }
        }

        minSteps := n
        for subset := available; subset > 0; subset = (subset - 1) & available {
            steps := 0
            for j := 0; j < n; j++ {
                if subset & (1 << j) != 0 {
                    steps++
                }
            }
            nextMask := mask | subset
            minSteps = min(minSteps, 1+dfs(nextMask))
        }

        memo[mask] = minSteps
        return minSteps
    }

    return dfs(0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}