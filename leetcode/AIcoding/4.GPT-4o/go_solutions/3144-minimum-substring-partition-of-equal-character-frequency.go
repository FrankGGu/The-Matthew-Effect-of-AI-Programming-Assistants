func minSubstringPartition(s string) int {
    count := [26]int{}
    for _, ch := range s {
        count[ch-'a']++
    }

    minLength := len(s)
    for freq := 1; freq <= 1000; freq++ {
        length := 0
        valid := true
        for i := 0; i < 26; i++ {
            if count[i] > 0 && count[i]%freq != 0 {
                valid = false
                break
            }
            length += count[i] / freq
        }
        if valid {
            minLength = min(minLength, length*freq)
        }
    }

    if minLength == len(s) {
        return -1
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}