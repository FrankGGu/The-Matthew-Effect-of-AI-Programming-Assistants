func executeInstructions(n int, startPos []int, s string) []int {
    result := make([]int, len(s))
    for i := 0; i < len(s); i++ {
        x, y := startPos[0], startPos[1]
        count := 0
        for j := i; j < len(s); j++ {
            switch s[j] {
            case 'L':
                y--
            case 'R':
                y++
            case 'U':
                x--
            case 'D':
                x++
            }
            if x < 0 || x >= n || y < 0 || y >= n {
                break
            }
            count++
        }
        result[i] = count
    }
    return result
}