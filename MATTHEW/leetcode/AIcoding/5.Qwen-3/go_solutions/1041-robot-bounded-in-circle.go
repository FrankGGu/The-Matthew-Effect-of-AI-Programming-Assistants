package main

func isRobotBounded(instructions string) bool {
    // Directions: North, East, South, West
    dx := []int{0, 1, 0, -1}
    dy := []int{1, 0, -1, 0}

    x, y := 0, 0
    dir := 0 // Start facing North

    for _, c := range instructions {
        if c == 'G' {
            x += dx[dir]
            y += dy[dir]
        } else if c == 'L' {
            dir = (dir + 3) % 4
        } else if c == 'R' {
            dir = (dir + 1) % 4
        }
    }

    return (x == 0 && y == 0) || dir != 0
}