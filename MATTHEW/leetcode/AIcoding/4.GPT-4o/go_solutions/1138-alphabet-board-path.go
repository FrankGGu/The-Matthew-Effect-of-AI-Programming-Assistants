func alphabetBoardPath(target string) string {
    var result strings.Builder
    x, y := 0, 0

    for _, c := range target {
        newX, newY := (c-'a')/5, (c-'a')%5
        if newX < x {
            for i := x; i > newX; i-- {
                result.WriteByte('U')
            }
        }
        if newY < y {
            for i := y; i > newY; i-- {
                result.WriteByte('L')
            }
        }
        if newX > x {
            for i := x; i < newX; i++ {
                result.WriteByte('D')
            }
        }
        if newY > y {
            for i := y; i < newY; i++ {
                result.WriteByte('R')
            }
        }
        result.WriteByte('!')
        x, y = newX, newY
    }

    return result.String()
}