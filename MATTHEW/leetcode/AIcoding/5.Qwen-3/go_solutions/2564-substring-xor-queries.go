package main

func substringXORQueries(s string, queries []int) [][]int {
    n := len(s)
    res := [][]int{}
    for _, q := range queries {
        found := false
        for i := 0; i < n && !found; i++ {
            if s[i] == '0' && q == 0 {
                res = append(res, []int{i, i})
                found = true
                continue
            }
            if s[i] == '1' && (q & 1) == 1 {
                start := i
                val := 0
                for j := i; j < n; j++ {
                    val = val*2 + int(s[j]-'0')
                    if val == q {
                        res = append(res, []int{start, j})
                        found = true
                        break
                    }
                }
            }
        }
        if !found {
            res = append(res, []int{-1, -1})
        }
    }
    return res
}