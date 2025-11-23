func countPalindromicSubsequence(s string) int {
    res := 0
    first := make([]int, 26)
    last := make([]int, 26)
    for i := 0; i < 26; i++ {
        first[i] = -1
        last[i] = -1
    }
    for i, c := range s {
        idx := int(c - 'a')
        if first[idx] == -1 {
            first[idx] = i
        }
        last[idx] = i
    }
    for i := 0; i < 26; i++ {
        if first[i] != -1 && last[i] - first[i] >= 2 {
            unique := make(map[byte]bool)
            for j := first[i] + 1; j < last[i]; j++ {
                unique[s[j]] = true
            }
            res += len(unique)
        }
    }
    return res
}