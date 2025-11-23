func longestUnequalAdjacentGroupsSubsequence(groups []int, words []string) []string {
    if len(groups) == 0 {
        return []string{}
    }

    result := []string{words[0]}
    lastGroup := groups[0]

    for i := 1; i < len(groups); i++ {
        if groups[i] != lastGroup {
            result = append(result, words[i])
            lastGroup = groups[i]
        }
    }

    return result
}