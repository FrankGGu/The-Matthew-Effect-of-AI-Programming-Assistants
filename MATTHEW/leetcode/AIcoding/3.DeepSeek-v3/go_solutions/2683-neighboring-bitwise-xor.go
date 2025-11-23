func doesValidArrayExist(derived []int) bool {
    n := len(derived)
    original := make([]int, n)

    // Try starting with 0
    original[0] = 0
    for i := 1; i < n; i++ {
        original[i] = original[i-1] ^ derived[i-1]
    }
    if (original[n-1] ^ original[0]) == derived[n-1] {
        return true
    }

    // Try starting with 1
    original[0] = 1
    for i := 1; i < n; i++ {
        original[i] = original[i-1] ^ derived[i-1]
    }
    if (original[n-1] ^ original[0]) == derived[n-1] {
        return true
    }

    return false
}