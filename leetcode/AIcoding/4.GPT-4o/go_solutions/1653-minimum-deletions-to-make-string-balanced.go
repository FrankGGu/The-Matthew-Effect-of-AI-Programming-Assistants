func minimumDeletions(s string) int {
    count := [26]int{}
    for _, char := range s {
        count[char-'a']++
    }

    seen := map[int]bool{}
    deletions := 0

    for i := 25; i >= 0; i-- {
        if count[i] == 0 {
            continue
        }

        for seen[count[i]] {
            count[i]--
            deletions++
        }

        if count[i] > 0 {
            seen[count[i]] = true
        }
    }

    return deletions
}