func pushDominoes(dominoes string) string {
    n := len(dominoes)
    forces := make([]int, n)
    force := 0

    for i := 0; i < n; i++ {
        if dominoes[i] == 'R' {
            force = n
        } else if dominoes[i] == 'L' {
            force = 0
        } else {
            force = max(force-1, 0)
        }
        forces[i] += force
    }

    force = 0
    for i := n - 1; i >= 0; i-- {
        if dominoes[i] == 'L' {
            force = n
        } else if dominoes[i] == 'R' {
            force = 0
        } else {
            force = max(force-1, 0)
        }
        forces[i] -= force
    }

    res := make([]byte, n)
    for i := 0; i < n; i++ {
        if forces[i] > 0 {
            res[i] = 'R'
        } else if forces[i] < 0 {
            res[i] = 'L'
        } else {
            res[i] = '.'
        }
    }
    return string(res)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}