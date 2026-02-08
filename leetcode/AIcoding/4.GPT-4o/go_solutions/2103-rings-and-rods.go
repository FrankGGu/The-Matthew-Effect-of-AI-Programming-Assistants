func countPoints(rings string) int {
    rod := make([]int, 10)
    for i := 0; i < len(rings); i += 2 {
        color := rings[i]
        rodIndex := rings[i+1] - '0'
        if color == 'R' {
            rod[rodIndex] |= 1 << 0
        } else if color == 'G' {
            rod[rodIndex] |= 1 << 1
        } else if color == 'B' {
            rod[rodIndex] |= 1 << 2
        }
    }
    count := 0
    for _, r := range rod {
        if r == 7 {
            count++
        }
    }
    return count
}