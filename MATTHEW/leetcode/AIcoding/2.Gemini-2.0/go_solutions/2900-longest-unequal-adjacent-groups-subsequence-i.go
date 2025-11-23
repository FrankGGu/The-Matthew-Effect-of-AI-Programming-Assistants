func longestUnequalAdjacentGroupsSubsequence(words []string, groups []int) []string {
    res := []string{words[0]}
    prevGroup := groups[0]
    for i := 1; i < len(words); i++ {
        if groups[i] != prevGroup {
            res = append(res, words[i])
            prevGroup = groups[i]
        }
    }
    return res
}