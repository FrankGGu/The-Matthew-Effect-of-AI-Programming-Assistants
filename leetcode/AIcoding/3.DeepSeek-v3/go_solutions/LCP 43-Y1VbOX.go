func trafficCommand(directions string) int {
    n := len(directions)
    if n == 0 {
        return 0
    }

    dp := make([][][][]int, 4)
    for i := 0; i < 4; i++ {
        dp[i] = make([][][]int, 4)
        for j := 0; j < 4; j++ {
            dp[i][j] = make([][]int, 4)
            for k := 0; k < 4; k++ {
                dp[i][j][k] = make([]int, 4)
                for l := 0; l < 4; l++ {
                    dp[i][j][k][l] = -1
                }
            }
        }
    }

    count := make([]int, 4)
    for _, c := range directions {
        switch c {
        case 'N':
            count[0]++
        case 'S':
            count[1]++
        case 'E':
            count[2]++
        case 'W':
            count[3]++
        }
    }

    var dfs func(a, b, c, d int) int
    dfs = func(a, b, c, d int) int {
        if a == count[0] && b == count[1] && c == count[2] && d == count[3] {
            return 0
        }
        if dp[a][b][c][d] != -1 {
            return dp[a][b][c][d]
        }

        res := math.MaxInt32
        for mask := 1; mask < 16; mask++ {
            na, nb, nc, nd := a, b, c, d
            if (mask & 1) > 0 && na < count[0] {
                na++
            }
            if (mask & 2) > 0 && nb < count[1] {
                nb++
            }
            if (mask & 4) > 0 && nc < count[2] {
                nc++
            }
            if (mask & 8) > 0 && nd < count[3] {
                nd++
            }

            if na == a && nb == b && nc == c && nd == d {
                continue
            }

            valid := true
            if (mask & 1) > 0 && (mask & 2) > 0 {
                valid = false
            }
            if (mask & 1) > 0 && (mask & 4) > 0 {
                valid = false
            }
            if (mask & 2) > 0 && (mask & 8) > 0 {
                valid = false
            }
            if (mask & 4) > 0 && (mask & 8) > 0 {
                valid = false
            }

            if valid {
                next := dfs(na, nb, nc, nd)
                if next + 1 < res {
                    res = next + 1
                }
            }
        }

        dp[a][b][c][d] = res
        return res
    }

    return dfs(0, 0, 0, 0)
}