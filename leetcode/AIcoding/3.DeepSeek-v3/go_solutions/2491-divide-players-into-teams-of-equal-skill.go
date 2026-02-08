func dividePlayers(skill []int) int64 {
    n := len(skill)
    if n%2 != 0 {
        return -1
    }

    totalSum := 0
    for _, s := range skill {
        totalSum += s
    }

    teamSize := n / 2
    targetSum := totalSum / teamSize
    if totalSum%teamSize != 0 {
        return -1
    }

    chemistry := int64(0)
    freq := make(map[int]int)
    for _, s := range skill {
        freq[s]++
    }

    for s, count := range freq {
        if count == 0 {
            continue
        }
        complement := targetSum - s
        if complementCount, exists := freq[complement]; !exists || complementCount != count {
            return -1
        }
        chemistry += int64(s * complement * count)
    }

    return chemistry / 2
}