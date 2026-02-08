func countBalls(lowLimit int, highLimit int) int {
    counts := make([]int, 46)

    for i := lowLimit; i <= highLimit; i++ {
        s := 0
        n := i
        for n > 0 {
            s += n % 10
            n /= 10
        }
        counts[s]++
    }

    maxCount := 0
    for _, count := range counts {
        if count > maxCount {
            maxCount = count
        }
    }

    return maxCount
}