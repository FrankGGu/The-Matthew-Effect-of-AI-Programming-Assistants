func findCelebrity(n int) int {
    candidate := 0
    for i := 1; i < n; i++ {
        if knows(candidate, i) {
            candidate = i
        }
    }

    for i := 0; i < n; i++ {
        if i == candidate {
            continue
        }
        if knows(candidate, i) || !knows(i, candidate) {
            return -1
        }
    }

    return candidate
}