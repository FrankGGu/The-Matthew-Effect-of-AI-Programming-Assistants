func possiblyEquals(s1 string, s2 string) bool {
    n, m := len(s1), len(s2)
    memo := make(map[[4]int]bool)

    var dfs func(i, j, diff int) bool
    dfs = func(i, j, diff int) bool {
        if i == n && j == m {
            return diff == 0
        }
        key := [4]int{i, j, diff}
        if v, ok := memo[key]; ok {
            return v
        }
        res := false

        if i < n && isDigit(s1[i]) {
            k := i
            num := 0
            for k < n && isDigit(s1[k]) {
                num = num*10 + int(s1[k]-'0')
                k++
                if dfs(k, j, diff-num) {
                    res = true
                    break
                }
            }
        } else if j < m && isDigit(s2[j]) {
            k := j
            num := 0
            for k < m && isDigit(s2[k]) {
                num = num*10 + int(s2[k]-'0')
                k++
                if dfs(i, k, diff+num) {
                    res = true
                    break
                }
            }
        } else if diff == 0 {
            if i < n && j < m && s1[i] == s2[j] {
                res = dfs(i+1, j+1, 0)
            }
        } else {
            if diff > 0 {
                if i < n {
                    res = dfs(i+1, j, diff-1)
                }
            } else {
                if j < m {
                    res = dfs(i, j+1, diff+1)
                }
            }
        }

        memo[key] = res
        return res
    }

    return dfs(0, 0, 0)
}

func isDigit(c byte) bool {
    return c >= '0' && c <= '9'
}