func appealSum(s string) int64 {
    lastPos := make([]int, 26)
    for i := range lastPos {
        lastPos[i] = -1
    }
    var res, sum int64
    for i := 0; i < len(s); i++ {
        c := int(s[i] - 'a')
        sum += int64(i - lastPos[c])
        res += sum
        lastPos[c] = i
    }
    return res
}