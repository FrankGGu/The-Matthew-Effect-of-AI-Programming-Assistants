func longestAwesome(s string) int {
    mask := 0
    res := 0
    pos := make([]int, 1<<10)
    for i := range pos {
        pos[i] = -2
    }
    pos[0] = -1
    for i := 0; i < len(s); i++ {
        mask ^= 1 << (s[i] - '0')
        if pos[mask] != -2 {
            res = max(res, i-pos[mask])
        } else {
            pos[mask] = i
        }
        for j := 0; j < 10; j++ {
            tmp := mask ^ (1 << j)
            if pos[tmp] != -2 {
                res = max(res, i-pos[tmp])
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}