func countBalls(lowLimit int, highLimit int) int {
    box := make(map[int]int)
    maxCount := 0

    for i := lowLimit; i <= highLimit; i++ {
        sum := 0
        num := i
        for num > 0 {
            sum += num % 10
            num /= 10
        }
        box[sum]++
        if box[sum] > maxCount {
            maxCount = box[sum]
        }
    }

    return maxCount
}