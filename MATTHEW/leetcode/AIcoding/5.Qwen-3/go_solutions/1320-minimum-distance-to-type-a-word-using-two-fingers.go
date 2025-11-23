package main

func minimumDistance(word string) int {
    dp := [26][26]int{}
    for i := range dp {
        for j := range dp[i] {
            dp[i][j] = 1<<30
        }
    }
    for i := 0; i < 26; i++ {
        dp[i][i] = 0
    }
    for i := 0; i < len(word); i++ {
        c := word[i] - 'a'
        next := [26][26]int{}
        for a := 0; a < 26; a++ {
            for b := 0; b < 26; b++ {
                next[a][b] = 1<<30
            }
        }
        for a := 0; a < 26; a++ {
            for b := 0; b < 26; b++ {
                if dp[a][b] == 1<<30 {
                    continue
                }
                if a == b {
                    next[a][c] = min(next[a][c], dp[a][b]+cost(a, c))
                    next[c][b] = min(next[c][b], dp[a][b]+cost(b, c))
                } else {
                    next[a][c] = min(next[a][c], dp[a][b]+cost(b, c))
                    next[c][b] = min(next[c][b], dp[a][b]+cost(a, c))
                }
            }
        }
        dp = next
    }
    res := 1<<30
    for i := 0; i < 26; i++ {
        for j := 0; j < 26; j++ {
            res = min(res, dp[i][j])
        }
    }
    return res
}

func cost(a, b int) int {
    x := a / 6
    y := a % 6
    x2 := b / 6
    y2 := b % 6
    return abs(x-x2) + abs(y-y2)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}