func numPairsDivisibleBy60(time []int) int {
    count := 0
    freq := make([]int, 60)

    for _, t := range time {
        remainder := t % 60
        complement := (60 - remainder) % 60
        count += freq[complement]
        freq[remainder]++
    }

    return count
}