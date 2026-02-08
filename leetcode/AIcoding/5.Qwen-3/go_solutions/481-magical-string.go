package main

func magicalString(n int) int {
    if n == 0 {
        return 0
    }
    if n <= 3 {
        return 1
    }
    s := make([]int, n)
    s[0] = 1
    s[1] = 2
    s[2] = 2
    i := 2
    j := 3
    for j < n {
        count := s[i]
        val := 1
        if s[i] == 1 {
            val = 2
        }
        for k := 0; k < count && j < n; k++ {
            s[j] = val
            j++
        }
        i++
    }
    res := 0
    for i := 0; i < n; i++ {
        if s[i] == 1 {
            res++
        }
    }
    return res
}