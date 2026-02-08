func minDeletions(s string) int {
    count := make([]int, 26)
    for _, ch := range s {
        count[ch-'a']++
    }

    sort.Sort(sort.Reverse(sort.IntSlice(count)))

    deletions := 0
    maxAllowed := len(s)

    for _, freq := range count {
        if freq > maxAllowed {
            deletions += freq - maxAllowed
            freq = maxAllowed
        }
        maxAllowed = max(0, freq-1)
    }

    return deletions
}