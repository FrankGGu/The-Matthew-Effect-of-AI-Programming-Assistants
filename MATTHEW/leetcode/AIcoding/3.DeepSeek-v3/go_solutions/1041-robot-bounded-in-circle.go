func isRobotBounded(instructions string) bool {
    x, y := 0, 0
    dirX, dirY := 0, 1

    for _, c := range instructions {
        if c == 'G' {
            x += dirX
            y += dirY
        } else if c == 'L' {
            dirX, dirY = -dirY, dirX
        } else if c == 'R' {
            dirX, dirY = dirY, -dirX
        }
    }

    return (x == 0 && y == 0) || (dirX != 0 || dirY != 1)
}