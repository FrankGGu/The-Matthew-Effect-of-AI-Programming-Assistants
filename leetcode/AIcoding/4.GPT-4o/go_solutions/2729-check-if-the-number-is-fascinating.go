func isFascinating(n int) bool {
    if n == 0 {
        return false
    }

    concatenated := fmt.Sprintf("%d%d%d", n, n*2, n*3)
    digitCount := make([]int, 10)

    for _, ch := range concatenated {
        digitCount[ch-'0']++
    }

    for i := 1; i <= 9; i++ {
        if digitCount[i] != 1 {
            return false
        }
    }

    return digitCount[0] == 0
}