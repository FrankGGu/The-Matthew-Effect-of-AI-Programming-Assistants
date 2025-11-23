func minimumDeletions(s string, k int) int {
    count := make([]int, 26)
    for _, char := range s {
        count[char-'a']++
    }

    sort.Slice(count, func(i, j int) bool {
        return count[i] > count[j]
    })

    deletions := 0
    for i := k; i < 26; i++ {
        deletions += count[i]
    }

    return deletions
}