package main

func lexSmallestBeautifulString(s string) string {
    n := len(s)
    res := make([]byte, n)
    for i := range s {
        res[i] = s[i]
    }

    for i := n - 1; i >= 0; i-- {
        for c := res[i] + 1; c <= 'z'; c++ {
            if i > 0 && c == res[i-1] {
                continue
            }
            if i > 1 && c == res[i-2] {
                continue
            }
            res[i] = c
            for j := i + 1; j < n; j++ {
                for k := 'a'; k <= 'z'; k++ {
                    if j > 0 && k == res[j-1] {
                        continue
                    }
                    if j > 1 && k == res[j-2] {
                        continue
                    }
                    res[j] = k
                    break
                }
            }
            return string(res)
        }
    }
    return string(res)
}