func maxGroups(cards []int) int {
    freq := make(map[int]int)
    for _, num := range cards {
        freq[num]++
    }

    counts := make([]int, 0, len(freq))
    for _, cnt := range freq {
        counts = append(counts, cnt)
    }
    sort.Ints(counts)

    res := 0
    for res+1 <= len(counts) && counts[res] >= res+1 {
        res++
    }
    return res
}