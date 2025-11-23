func canMakeSubsequence(str1 string, str2 string) bool {
    i, j := 0, 0
    n, m := len(str1), len(str2)
    for i < n && j < m {
        c1 := str1[i]
        c2 := str2[j]
        if c1 == c2 || (c1+1-'a')%26+'a' == c2 {
            j++
        }
        i++
    }
    return j == m
}