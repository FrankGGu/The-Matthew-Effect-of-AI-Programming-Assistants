func alphabetBoardPath(target string) string {
    board := []string{"abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"}
    pos := make(map[byte][2]int)
    for i, row := range board {
        for j, c := range row {
            pos[byte(c)] = [2]int{i, j}
        }
    }

    var res []byte
    x, y := 0, 0
    for _, c := range target {
        nx, ny := pos[byte(c)][0], pos[byte(c)][1]
        for y > ny {
            res = append(res, 'L')
            y--
        }
        for x > nx {
            res = append(res, 'U')
            x--
        }
        for x < nx {
            res = append(res, 'D')
            x++
        }
        for y < ny {
            res = append(res, 'R')
            y++
        }
        res = append(res, '!')
    }
    return string(res)
}