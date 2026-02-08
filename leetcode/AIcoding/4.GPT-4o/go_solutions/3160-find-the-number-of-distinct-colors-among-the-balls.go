func countBalls(lowLimit int, highLimit int) int {
    colorCount := make(map[int]int)
    for i := lowLimit; i <= highLimit; i++ {
        sum := 0
        num := i
        for num > 0 {
            sum += num % 10
            num /= 10
        }
        colorCount[sum]++
    }
    maxCount := 0
    for _, count := range colorCount {
        if count > maxCount {
            maxCount = count
        }
    }
    return maxCount
}