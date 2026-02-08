func minSetSize(arr []int) int {
    freq := make(map[int]int)
    for _, num := range arr {
        freq[num]++
    }

    counts := make([]int, 0, len(freq))
    for _, count := range freq {
        counts = append(counts, count)
    }

    sort.Slice(counts, func(i, j int) bool {
        return counts[i] > counts[j]
    })

    half := len(arr) / 2
    currentSize := 0
    sets := 0

    for _, count := range counts {
        currentSize += count
        sets++
        if currentSize >= half {
            break
        }
    }

    return sets
}