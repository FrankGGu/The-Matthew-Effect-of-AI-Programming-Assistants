func shiftingLetters(s string, shifts [][]int) string {
    n := len(s)
    diff := make([]int, n+1)

    for _, shift := range shifts {
        start, end, dir := shift[0], shift[1], shift[2]
        if dir == 1 {
            diff[start]++
            if end+1 < n {
                diff[end+1]--
            }
        } else {
            diff[start]--
            if end+1 < n {
                diff[end+1]++
            }
        }
    }

    res := make([]byte, n)
    shift := 0
    for i := 0; i < n; i++ {
        shift += diff[i]
        res[i] = byte((int(s[i]-'a') + shift) % 26)
        if res[i] < 0 {
            res[i] += 26
        }
        res[i] += 'a'
    }

    return string(res)
}