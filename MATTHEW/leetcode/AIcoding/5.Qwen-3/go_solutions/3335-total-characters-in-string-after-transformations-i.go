package main

func numberOfUniqueChars(s string) int {
    n := len(s)
    pre := make([]int, n)
    post := make([]int, n)
    count := make(map[byte]int)

    for i := 0; i < n; i++ {
        if val, ok := count[s[i]]; ok {
            pre[i] = val
        } else {
            pre[i] = -1
        }
        count[s[i]] = i
    }

    count = make(map[byte]int)
    for i := n - 1; i >= 0; i-- {
        if val, ok := count[s[i]]; ok {
            post[i] = val
        } else {
            post[i] = n
        }
        count[s[i]] = i
    }

    res := 0
    for i := 0; i < n; i++ {
        res += (i - pre[i]) * (post[i] - i)
    }
    return res
}