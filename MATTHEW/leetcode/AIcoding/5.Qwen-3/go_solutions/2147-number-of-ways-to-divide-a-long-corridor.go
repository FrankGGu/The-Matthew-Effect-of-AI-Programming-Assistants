package main

func numberOfWays(s string) int {
    mod := 1000000007
    count := 0
    for i := 0; i < len(s); i++ {
        if s[i] == 's' {
            count++
        }
    }
    if count%2 != 0 {
        return 0
    }
    res := 1
    pos := 0
    for i := 0; i < len(s); i++ {
        if s[i] == 's' {
            pos++
            if pos%2 == 0 {
                left := 0
                right := 0
                j := i - 1
                for j >= 0 && s[j] == 's' {
                    left++
                    j--
                }
                j = i + 1
                for j < len(s) && s[j] == 's' {
                    right++
                    j++
                }
                res = (res * (left + 1) % mod) * (right + 1) % mod
            }
        }
    }
    return res
}