func numPairsDivisibleBy60(time []int) int {
    remainderCounts := [60]int{}
    pairs := 0

    for _, t := range time {
        remainder := t % 60
        complement := (60 - remainder) % 60

        pairs += remainderCounts[complement]
        remainderCounts[remainder]++
    }

    return pairs
}