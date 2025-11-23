func lastSubstring(s string) string {
    maxChar := byte(0)
    candidates := []int{}
    for i := 0; i < len(s); i++ {
        if s[i] > maxChar {
            maxChar = s[i]
            candidates = []int{i}
        } else if s[i] == maxChar {
            candidates = append(candidates, i)
        }
    }

    if len(candidates) == 1 {
        return s[candidates[0]:]
    }

    maxPos := candidates[0]
    for i := 1; i < len(candidates); i++ {
        pos := candidates[i]
        offset := 0
        for maxPos+offset < len(s) && pos+offset < len(s) {
            if s[maxPos+offset] != s[pos+offset] {
                break
            }
            offset++
        }
        if pos+offset == len(s) {
            continue
        }
        if maxPos+offset < len(s) && pos+offset < len(s) && s[pos+offset] > s[maxPos+offset] {
            maxPos = pos
        }
    }

    return s[maxPos:]
}