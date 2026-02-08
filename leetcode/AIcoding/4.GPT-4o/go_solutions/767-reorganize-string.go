func reorganizeString(S string) string {
    count := make([]int, 26)
    for _, ch := range S {
        count[ch-'a']++
    }

    maxCount := 0
    maxChar := 0
    for i, c := range count {
        if c > maxCount {
            maxCount = c
            maxChar = i
        }
    }

    if maxCount > (len(S)+1)/2 {
        return ""
    }

    result := make([]byte, len(S))
    idx := 0
    for i := 0; i < maxCount; i++ {
        result[idx] = byte(maxChar + 'a')
        idx += 2
    }
    count[maxChar] = 0

    for i := 0; i < 26; i++ {
        for count[i] > 0 {
            if idx >= len(S) {
                idx = 1
            }
            result[idx] = byte(i + 'a')
            idx++
            count[i]--
        }
    }

    return string(result)
}