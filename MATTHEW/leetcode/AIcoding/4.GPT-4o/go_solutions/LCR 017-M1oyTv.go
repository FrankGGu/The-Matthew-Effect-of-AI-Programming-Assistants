func minWindow(s string, t string) string {
    if len(t) == 0 || len(s) < len(t) {
        return ""
    }

    need := make(map[byte]int)
    for i := 0; i < len(t); i++ {
        need[t[i]]++
    }

    left, right := 0, 0
    valid := 0
    minLen := len(s) + 1
    start := 0

    window := make(map[byte]int)

    for right < len(s) {
        c := s[right]
        right++
        if _, ok := need[c]; ok {
            window[c]++
            if window[c] == need[c] {
                valid++
            }
        }

        for valid == len(need) {
            if right-left < minLen {
                minLen = right - left
                start = left
            }
            d := s[left]
            left++
            if _, ok := need[d]; ok {
                if window[d] == need[d] {
                    valid--
                }
                window[d]--
            }
        }
    }

    if minLen == len(s)+1 {
        return ""
    }
    return s[start : start+minLen]
}