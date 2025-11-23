func canMakePaliQueries(s string, queries [][]int) []bool {
    n := len(s)
    prefix := make([][26]int, n+1)
    for i := 0; i < n; i++ {
        for j := 0; j < 26; j++ {
            prefix[i+1][j] = prefix[i][j]
        }
        prefix[i+1][s[i]-'a']++
    }

    res := make([]bool, len(queries))
    for i, q := range queries {
        left, right, k := q[0], q[1], q[2]
        odd := 0
        for j := 0; j < 26; j++ {
            cnt := prefix[right+1][j] - prefix[left][j]
            if cnt % 2 != 0 {
                odd++
            }
        }
        res[i] = odd / 2 <= k
    }
    return res
}