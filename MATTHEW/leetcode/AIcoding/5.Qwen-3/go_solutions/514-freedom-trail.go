package main

func findRotateSteps(ring string, key string) int {
    n := len(ring)
    m := len(key)
    memo := make([][]int, n)
    for i := range memo {
        memo[i] = make([]int, m)
    }
    return dfs(ring, key, 0, 0, memo, n, m)
}

func dfs(ring string, key string, pos int, idx int, memo [][]int, n, m int) int {
    if idx == len(key) {
        return 0
    }
    if memo[pos][idx] != 0 {
        return memo[pos][idx]
    }
    target := key[idx]
    minSteps := math.MaxInt32
    for i := 0; i < len(ring); i++ {
        if ring[i] == target {
            steps := 0
            if pos <= i {
                steps = i - pos
            } else {
                steps = pos - i
            }
            steps += 1 // add the step to press the button
            res := steps + dfs(ring, key, i, idx+1, memo, n, m)
            if res < minSteps {
                minSteps = res
            }
        }
    }
    memo[pos][idx] = minSteps
    return minSteps
}