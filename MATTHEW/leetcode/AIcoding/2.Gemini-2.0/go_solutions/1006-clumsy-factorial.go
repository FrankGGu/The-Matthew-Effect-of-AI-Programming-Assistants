func clumsy(N int) int {
    if N == 1 {
        return 1
    }
    if N == 2 {
        return 2
    }
    if N == 3 {
        return 6
    }
    if N == 4 {
        return 7
    }

    result := N*(N-1)/(N-2) + (N-3)
    N -= 4
    for N > 0 {
        term := -(N*(N-1)/(N-2)) + (N-3)
        result += term
        N -= 4
    }

    return result
}