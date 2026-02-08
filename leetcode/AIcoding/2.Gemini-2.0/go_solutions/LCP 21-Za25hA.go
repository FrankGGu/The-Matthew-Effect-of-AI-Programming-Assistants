func canCatch(n int, startAlice int, startBob int, movesAlice int, movesBob int) bool {
    if movesBob >= n {
        return true
    }
    if movesAlice*2 >= movesBob {
        return true
    }
    return false
}