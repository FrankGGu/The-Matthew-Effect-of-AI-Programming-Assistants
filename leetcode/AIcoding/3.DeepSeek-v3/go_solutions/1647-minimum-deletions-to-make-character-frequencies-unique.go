func minDeletions(s string) int {
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }

    used := make(map[int]bool)
    deletions := 0

    for _, count := range freq {
        for count > 0 && used[count] {
            count--
            deletions++
        }
        if count > 0 {
            used[count] = true
        }
    }

    return deletions
}