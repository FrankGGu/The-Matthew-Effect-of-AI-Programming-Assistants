func getWordsInLongestSubsequence(n int, words []string, groups []int) []string {
    var res []string
    for i := 0; i < n; i++ {
        if i == 0 || groups[i] != groups[i-1] {
            res = append(res, words[i])
        }
    }
    return res
}