type Robot struct {
    width, height int
    perimeter int
    pos int // current position along the perimeter, 0 to perimeter-1
    isMoved bool

    pathPoints [][2]int
    pathDirs []int // 0:East, 1:North, 2:West, 3:South
}

func Constructor(width int, height int) Robot {
    r := Robot{
        width: width,
        height: height,
        isMoved: false,
    }

    w1 := width - 1
    h1 := height - 1
    r.perimeter = 2*w1 + 2*h1

    if r.perimeter == 0 { // Special case for 1x1 grid (width=1, height=1)
        r.pathPoints = [][2]int{{0, 0}}
        r.pathDirs = []int{0} // Direction doesn't matter much for 1x1, GetDir handles it
        return r
    }

    tempPoints := make([][2]int, 0, r.perimeter)

    // East segment: (0,0) -> (w1,0)
    for i := 0; i < w1; i++ { // Points (0,0) to (w1-1,0)
        tempPoints = append(tempPoints, [2]int{i, 0})
    }
    // North segment: (w1,0) -> (w1,h1)
    for i := 0; i < h1; i++ { // Points (w1,0) to (w1,h1-1)
        tempPoints = append(tempPoints, [2]int{w1, i})
    }
    // West segment: (w1,h1) -> (0,h1)
    for i := 0; i < w1; i++ { // Points (w1,h1) to (1,h1)
        tempPoints = append(tempPoints, [2]int{w1 - i, h1})
    }
    // South segment: (0,h1) -> (0,0)
    for i := 0; i < h1; i++ { // Points (0,h1) to (0,1)
        tempPoints = append(tempPoints, [2]int{0, h1 - i})
    }

    r.pathPoints = tempPoints
    r.pathDirs = make([]int, r.perimeter)

    for i := 0; i < r.perimeter; i++ {
        currX, currY := tempPoints[i][0], tempPoints[i][1]
        nextX, nextY := tempPoints[(i+1)%r.perimeter][0], tempPoints[(i+1)%r.perimeter][1]

        if nextX > currX {
            r.pathDirs[i] = 0 // East
        } else if nextY > currY {
            r.pathDirs[i] = 1 // North
        } else if nextX < currX {
            r.pathDirs[i] = 2 // West
        } else { // nextY < currY
            r.pathDirs[i] = 3 // South
        }
    }

    return r
}

func (r *Robot) Step(num int) {
    if r.perimeter == 0 { // 1x1 grid
        r.isMoved = true
        return
    }
    r.pos = (r.pos + num) % r.perimeter
    r.isMoved = true
}

func (r *Robot) GetPos() []int {
    if r.perimeter == 0 { // 1x1 grid
        return []int{0, 0}
    }
    return r.pathPoints[r.pos]
}

func (r *Robot) GetDir() string {
    strDirs := []string{"East", "North", "West", "South"}

    if r.perimeter == 0 { // 1x1 grid
        if r.isMoved {
            return "South"
        }
        return "East"
    }

    // Special rule for (0,0)
    // "If the robot is at (0, 0) and has moved, its direction is South. Otherwise, its direction is East."
    // (0,0) corresponds to r.pos == 0.
    if r.pos == 0 {
        if r.isMoved {
            return "South"
        }
        return "East"
    }
    return strDirs[r.pathDirs[r.pos]]
}