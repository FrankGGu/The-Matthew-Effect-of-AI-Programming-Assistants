func minInteger(num string, k int) string {
    n := len(num)
    if k == 0 || n <= 1 {
        return num
    }

    pos := make([][]int, 10)
    for i, ch := range num {
        pos[ch-'0'] = append(pos[ch-'0'], i)
    }

    result := make([]byte, n)
    for i := 0; i < n; i++ {
        for d := 0; d < 10; d++ {
            if len(pos[d]) > 0 && pos[d][0] <= i+k {
                result[i] = byte(d + '0')
                k -= pos[d][0] - i
                pos[d] = pos[d][1:]
                if k < 0 {
                    return ""
                }
                break
            }
        }
    }

    return string(result)
}