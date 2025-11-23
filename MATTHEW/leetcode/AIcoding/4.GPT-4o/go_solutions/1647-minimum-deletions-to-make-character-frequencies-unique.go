func minDeletions(s string) int {
    freq := make([]int, 26)
    for _, ch := range s {
        freq[ch-'a']++
    }

    seen := make(map[int]bool)
    deletions := 0

    for _, f := range freq {
        for f > 0 && seen[f] {
            f--
            deletions++
        }
        seen[f] = true
    }

    return deletions
}