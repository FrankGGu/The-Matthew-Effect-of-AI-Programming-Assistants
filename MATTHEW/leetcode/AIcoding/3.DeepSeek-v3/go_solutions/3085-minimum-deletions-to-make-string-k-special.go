func minimumDeletions(word string, k int) int {
    freq := make(map[rune]int)
    for _, ch := range word {
        freq[ch]++
    }

    counts := make([]int, 0, len(freq))
    for _, cnt := range freq {
        counts = append(counts, cnt)
    }
    sort.Ints(counts)

    minDeletions := math.MaxInt32
    for i := 0; i < len(counts); i++ {
        target := counts[i]
        deletions := 0
        for j := 0; j < len(counts); j++ {
            if counts[j] < target {
                deletions += counts[j]
            } else if counts[j] > target + k {
                deletions += counts[j] - (target + k)
            }
        }
        if deletions < minDeletions {
            minDeletions = deletions
        }
    }

    return minDeletions
}