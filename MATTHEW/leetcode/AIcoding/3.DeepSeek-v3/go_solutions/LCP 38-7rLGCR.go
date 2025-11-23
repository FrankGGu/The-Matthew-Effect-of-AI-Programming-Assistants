func guardCastle(grid []string) int {
    n := len(grid)
    m := len(grid[0])
    const INF = 1 << 30
    var dp [2][2][2]int
    for i := 0; i < 2; i++ {
        for j := 0; j < 2; j++ {
            for k := 0; k < 2; k++ {
                dp[i][j][k] = INF
            }
        }
    }
    dp[0][0][0] = 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            c := grid[i][j]
            var ndp [2][2][2]int
            for a := 0; a < 2; a++ {
                for b := 0; b < 2; b++ {
                    for d := 0; d < 2; d++ {
                        ndp[a][b][d] = INF
                    }
                }
            }
            for a := 0; a < 2; a++ {
                for b := 0; b < 2; b++ {
                    for d := 0; d < 2; d++ {
                        if dp[a][b][d] == INF {
                            continue
                        }
                        for na := 0; na < 2; na++ {
                            for nb := 0; nb < 2; nb++ {
                                if c == 'S' && (na != 1 || nb != 1) {
                                    continue
                                }
                                if c == 'C' && (na != 0 || nb != 0) {
                                    continue
                                }
                                if c == 'P' && (na != 0 || nb != 1) && (na != 1 || nb != 0) {
                                    continue
                                }
                                cost := 0
                                if c == '.' {
                                    if na == 1 && nb == 1 {
                                        cost = 1
                                    } else if na == 0 && nb == 0 {
                                        cost = 1
                                    }
                                }
                                nd := d
                                if c == 'P' {
                                    nd = 1
                                }
                                if ndp[na][nb][nd] > dp[a][b][d]+cost {
                                    ndp[na][nb][nd] = dp[a][b][d] + cost
                                }
                            }
                        }
                    }
                }
            }
            dp = ndp
        }
    }
    res := INF
    for a := 0; a < 2; a++ {
        for b := 0; b < 2; b++ {
            for d := 0; d < 2; d++ {
                if dp[a][b][d] < res {
                    res = dp[a][b][d]
                }
            }
        }
    }
    if res == INF {
        return -1
    }
    return res
}