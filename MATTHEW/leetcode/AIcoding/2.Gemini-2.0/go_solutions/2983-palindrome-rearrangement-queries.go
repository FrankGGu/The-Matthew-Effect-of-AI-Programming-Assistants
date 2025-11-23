func canRearrangePalindrome(s string, queries [][]int) []bool {
    n := len(s)
    m := len(queries)
    prefix := make([][26]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i]
        prefix[i+1][s[i]-'a']++
    }
    result := make([]bool, m)
    for i := 0; i < m; i++ {
        left, right := queries[i][0], queries[i][1]
        counts := [26]int{}
        for j := 0; j < 26; j++ {
            counts[j] = prefix[right+1][j] - prefix[left][j]
        }
        oddCount := 0
        for j := 0; j < 26; j++ {
            if counts[j]%2 != 0 {
                oddCount++
            }
        }
        length := right - left + 1
        subs := queries[i][2]
        if oddCount <= 2*subs+1 {
            result[i] = true
        } else {
            result[i] = false
        }
    }
    return result
}