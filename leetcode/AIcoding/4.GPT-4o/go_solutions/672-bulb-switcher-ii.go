func flipLights(n int, presses int) int {
    if n == 0 {
        return 0
    }
    if presses == 0 {
        return 1
    }

    states := map[int]struct{}{
        0: {},
        1: {},
        2: {},
        3: {},
        4: {},
        5: {},
        6: {},
        7: {},
    }

    if n == 1 {
        return min(presses+1, 2)
    }
    if n == 2 {
        return min((presses+1)/2*2, 3)
    }

    if presses == 1 {
        return 4
    }
    if presses == 2 {
        return 7
    }

    return 8
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}