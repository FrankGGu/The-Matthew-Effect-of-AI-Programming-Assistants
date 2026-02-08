func robot(command string, obstacles [][]int, x int, y int) bool {
    u, v := 0, 0
    path := make(map[[2]int]bool)
    path[[2]int{u, v}] = true
    for _, c := range command {
        if c == 'U' {
            v++
        } else {
            u++
        }
        path[[2]int{u, v}] = true
    }

    cycle := u + v
    for _, obs := range obstacles {
        ox, oy := obs[0], obs[1]
        if ox > x || oy > y {
            continue
        }
        min := ox
        if oy < min {
            min = oy
        }
        k := min / cycle
        ox -= k * cycle
        oy -= k * cycle
        if path[[2]int{ox, oy}] {
            return false
        }
    }

    min := x
    if y < min {
        min = y
    }
    k := min / cycle
    x -= k * cycle
    y -= k * cycle
    return path[[2]int{x, y}]
}