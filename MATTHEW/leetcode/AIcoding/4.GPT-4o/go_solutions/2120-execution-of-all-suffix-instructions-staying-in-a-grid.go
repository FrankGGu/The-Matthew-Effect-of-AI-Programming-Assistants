func executeInstructions(n int, startPos []int, s string) []int {
    res := make([]int, len(s))
    directions := map[rune][2]int{
        'L': {0, -1},
        'R': {0, 1},
        'U': {-1, 0},
        'D': {1, 0},
    }

    for i := 0; i < len(s); i++ {
        x, y := startPos[0], startPos[1]
        count := 0
        for j := i; j < len(s); j++ {
            dx, dy := directions[rune(s[j])]
            x += dx
            y += dy
            if x < 0 || x >= n || y < 0 || y >= n {
                break
            }
            count++
        }
        res[i] = count
    }

    return res
}