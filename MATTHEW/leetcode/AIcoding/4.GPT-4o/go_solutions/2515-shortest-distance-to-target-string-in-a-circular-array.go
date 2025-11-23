func closetTarget(words []string, target string, startIndex int) int {
    n := len(words)
    if n == 0 {
        return -1
    }

    for i := 0; i < n; i++ {
        idx := (startIndex + i) % n
        if words[idx] == target {
            return i
        }
        idx = (startIndex - i + n) % n
        if words[idx] == target {
            return i
        }
    }

    return -1
}