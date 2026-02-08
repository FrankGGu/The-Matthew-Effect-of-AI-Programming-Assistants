func isTransformable(s string, t string) bool {
    pos := make([][]int, 10)
    for i := len(s) - 1; i >= 0; i-- {
        digit := int(s[i] - '0')
        pos[digit] = append(pos[digit], i)
    }

    for _, ch := range t {
        digit := int(ch - '0')
        if len(pos[digit]) == 0 {
            return false
        }
        for d := 0; d < digit; d++ {
            if len(pos[d]) > 0 && pos[d][len(pos[d])-1] < pos[digit][len(pos[digit])-1] {
                return false
            }
        }
        pos[digit] = pos[digit][:len(pos[digit])-1]
    }
    return true
}