package main

func canMakePalindromeQueries(s string, queries [][]int) []bool {
    n := len(s)
    pre := make([][26]int, n+1)
    for i := 0; i < n; i++ {
        for j := 0; j < 26; j++ {
            pre[i+1][j] = pre[i][j]
        }
        pre[i+1][s[i]-'a']++
    }

    res := make([]bool, len(queries))
    for i, q := range queries {
        l, r := q[0], q[1]
        cnt := [26]int{}
        for j := l; j <= r; j++ {
            cnt[s[j]-'a']++
        }
        ok := true
        for j := 0; j < 26; j++ {
            if cnt[j]%2 != 0 {
                ok = false
                break
            }
        }
        res[i] = ok
    }
    return res
}