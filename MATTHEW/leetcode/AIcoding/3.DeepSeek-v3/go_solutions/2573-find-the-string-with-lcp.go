func findTheString(lcp [][]int) string {
    n := len(lcp)
    if n == 0 {
        return ""
    }
    res := make([]byte, n)
    res[0] = 'a'
    for i := 1; i < n; i++ {
        res[i] = 'a'
        for c := byte('a'); c <= 'z'; c++ {
            ok := true
            for j := 0; j < i; j++ {
                if res[j] == c {
                    if (i == n-1 || j == n-1) && lcp[i][j] != 1 {
                        ok = false
                        break
                    } else if i < n-1 && j < n-1 {
                        if lcp[i][j] != lcp[i+1][j+1]+1 {
                            ok = false
                            break
                        }
                    }
                }
            }
            if ok {
                res[i] = c
                break
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i == j {
                if lcp[i][j] != n-i {
                    return ""
                }
            } else {
                if res[i] != res[j] {
                    if lcp[i][j] != 0 {
                        return ""
                    }
                } else {
                    if i == n-1 || j == n-1 {
                        if lcp[i][j] != 1 {
                            return ""
                        }
                    } else {
                        if lcp[i][j] != lcp[i+1][j+1]+1 {
                            return ""
                        }
                    }
                }
            }
        }
    }
    return string(res)
}