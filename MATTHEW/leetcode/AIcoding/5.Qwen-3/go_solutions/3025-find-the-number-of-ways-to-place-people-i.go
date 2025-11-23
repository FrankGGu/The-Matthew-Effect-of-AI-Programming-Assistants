package main

func numberOfWays(people [][]int) int {
    sort.Slice(people, func(i, j int) bool {
        if people[i][0] == people[j][0] {
            return people[i][1] < people[j][1]
        }
        return people[i][0] < people[j][0]
    })

    n := len(people)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if people[j][1] < people[i][1] {
                dp[i] += dp[j]
            }
        }
    }

    result := 0
    for _, v := range dp {
        result += v
    }
    return result
}