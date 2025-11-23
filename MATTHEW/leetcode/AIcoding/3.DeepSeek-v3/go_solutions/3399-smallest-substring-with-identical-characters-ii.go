func smallestSubstring(s string) string {
    n := len(s)
    if n == 0 {
        return ""
    }

    left := 0
    minLen := n
    start := 0
    count := make(map[byte]int)
    maxFreq := 0

    for right := 0; right < n; right++ {
        char := s[right]
        count[char]++
        if count[char] > maxFreq {
            maxFreq = count[char]
        }

        for right - left + 1 > maxFreq {
            leftChar := s[left]
            count[leftChar]--
            if count[leftChar] == maxFreq - 1 {
                maxFreq--
            }
            left++
        }

        if right - left + 1 == maxFreq && right - left + 1 < minLen {
            minLen = right - left + 1
            start = left
        }
    }

    return s[start : start + minLen]
}