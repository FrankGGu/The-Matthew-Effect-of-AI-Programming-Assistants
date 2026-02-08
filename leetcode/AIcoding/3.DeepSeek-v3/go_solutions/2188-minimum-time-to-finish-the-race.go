func minimumFinishTime(tires [][]int, changeTime int, numLaps int) int {
    minWithoutChange := make([]int, 20)
    for i := range minWithoutChange {
        minWithoutChange[i] = math.MaxInt32
    }
    for _, tire := range tires {
        f, r := tire[0], tire[1]
        time, lap := 0, 1
        for {
            t := f * int(math.Pow(float64(r), float64(lap-1)))
            if t > changeTime + f {
                break
            }
            time += t
            if time < minWithoutChange[lap] {
                minWithoutChange[lap] = time
            }
            lap++
        }
    }

    dp := make([]int, numLaps+1)
    for i := 1; i <= numLaps; i++ {
        dp[i] = math.MaxInt32
        for j := 1; j <= i && j < 20; j++ {
            if minWithoutChange[j] == math.MaxInt32 {
                continue
            }
            if i == j {
                dp[i] = min(dp[i], minWithoutChange[j])
            } else {
                dp[i] = min(dp[i], minWithoutChange[j]+changeTime+dp[i-j])
            }
        }
    }
    return dp[numLaps]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}