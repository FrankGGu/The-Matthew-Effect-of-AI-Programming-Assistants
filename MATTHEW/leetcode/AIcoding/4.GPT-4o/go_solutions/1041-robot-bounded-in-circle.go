func isRobotBounded(instructions string) bool {
    x, y := 0, 0
    // Directions: North, East, South, West
    dx, dy := 0, 1

    for _, instruction := range instructions {
        if instruction == 'G' {
            x += dx
            y += dy
        } else if instruction == 'L' {
            dx, dy = -dy, dx
        } else if instruction == 'R' {
            dx, dy = dy, -dx
        }
    }
    return (x == 0 && y == 0) || (dx != 0 || dy != 1)
}