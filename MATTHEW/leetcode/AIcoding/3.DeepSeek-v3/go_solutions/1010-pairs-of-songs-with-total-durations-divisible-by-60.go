func numPairsDivisibleBy60(time []int) int {
    count := make([]int, 60)
    res := 0
    for _, t := range time {
        remainder := t % 60
        complement := (60 - remainder) % 60
        res += count[complement]
        count[remainder]++
    }
    return res
}