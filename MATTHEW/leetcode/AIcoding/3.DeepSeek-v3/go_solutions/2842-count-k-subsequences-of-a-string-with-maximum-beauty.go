func countKSubsequencesWithMaxBeauty(s string, k int) int {
    const mod = 1e9 + 7
    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
    }
    if len(freq) < k {
        return 0
    }
    counts := make([]int, 0, len(freq))
    for _, cnt := range freq {
        counts = append(counts, cnt)
    }
    sort.Slice(counts, func(i, j int) bool {
        return counts[i] > counts[j]
    })
    res := 1
    m := 0
    for i := 0; i < k; i++ {
        res = res * counts[i] % mod
    }
    for i := 0; i < len(counts); i++ {
        if counts[i] == counts[k-1] {
            m++
        }
    }
    n := 0
    for i := 0; i < k; i++ {
        if counts[i] == counts[k-1] {
            n++
        }
    }
    comb := 1
    for i := 1; i <= n; i++ {
        comb = comb * (m - i + 1) / i
    }
    res = res * comb % mod
    return res
}