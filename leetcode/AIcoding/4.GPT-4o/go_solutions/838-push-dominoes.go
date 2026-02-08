func pushDominoes(dominoes string) string {
    n := len(dominoes)
    result := []byte(dominoes)
    forces := make([]int, n)

    for i := 0; i < n; i++ {
        if result[i] == 'R' {
            forces[i] = n
        } else if result[i] == 'L' {
            forces[i] = -n
        }
    }

    for i := 0; i < n; i++ {
        if forces[i] > 0 {
            for j := i + 1; j < n && forces[j] != -n; j++ {
                forces[j] += forces[i]
            }
        } else if forces[i] < 0 {
            for j := i - 1; j >= 0 && forces[j] != n; j-- {
                forces[j] += forces[i]
            }
        }
    }

    for i := 0; i < n; i++ {
        if forces[i] > 0 {
            result[i] = 'R'
        } else if forces[i] < 0 {
            result[i] = 'L'
        } else {
            result[i] = '.'
        }
    }

    return string(result)
}