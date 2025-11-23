func countPalindromicSubsequences(s string) int {
    n := len(s)

    firstIdx := [26]int{}
    lastIdx := [26]int{}

    for i := 0; i < 26; i++ {
        firstIdx[i] = -1
        lastIdx