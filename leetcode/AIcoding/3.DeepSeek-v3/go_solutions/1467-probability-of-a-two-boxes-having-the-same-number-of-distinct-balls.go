func getProbability(balls []int) float64 {
    total := 0
    for _, b := range balls {
        total += b
    }
    half := total / 2

    fact := make([]int, total+1)
    fact[0] = 1
    for i := 1; i <= total; i++ {
        fact[i] = fact[i-1] * i
    }

    var dfs func(pos, sumA, colorA, colorB int) (int, int)
    dfs = func(pos, sumA, colorA, colorB int) (int, int) {
        if sumA > half {
            return 0, 0
        }
        if pos == len(balls) {
            if sumA != half {
                return 0, 0
            }
            if colorA != colorB {
                return 0, 0
            }
            ways := fact[half] * fact[half]
            for _, b := range balls {
                ways /= fact[b]
            }
            return ways, ways
        }

        totalWays, validWays := 0, 0
        for i := 0; i <= balls[pos]; i++ {
            newSumA := sumA + i
            newColorA := colorA
            if i > 0 {
                newColorA++
            }
            newColorB := colorB
            if balls[pos]-i > 0 {
                newColorB++
            }
            ways := fact[balls[pos]] / (fact[i] * fact[balls[pos]-i])
            w, v := dfs(pos+1, newSumA, newColorA, newColorB)
            totalWays += ways * w
            validWays += ways * v
        }
        return totalWays, validWays
    }

    totalWays, validWays := dfs(0, 0, 0, 0)
    return float64(validWays) / float64(totalWays)
}