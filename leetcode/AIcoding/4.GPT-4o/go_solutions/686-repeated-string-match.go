func repeatedStringMatch(A string, B string) int {
    count := 1
    repeatedA := A

    for len(repeatedA) < len(B) {
        repeatedA += A
        count++
    }

    if strings.Contains(repeatedA, B) {
        return count
    }

    repeatedA += A
    if strings.Contains(repeatedA, B) {
        return count + 1
    }

    return -1
}