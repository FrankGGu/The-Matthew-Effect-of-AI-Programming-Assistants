func minSetSize(arr []int) int {
    freq := make(map[int]int)
    for _, num := range arr {
        freq[num]++
    }

    counts := make([]int, 0, len(freq))
    for _, cnt := range freq {
        counts = append(counts, cnt)
    }

    sort.Slice(counts, func(i, j int) bool {
        return counts[i] > counts[j]
    })

    total, res := 0, 0
    half := len(arr) / 2
    for _, cnt := range counts {
        total += cnt
        res++
        if total >= half {
            break
        }
    }

    return res
}