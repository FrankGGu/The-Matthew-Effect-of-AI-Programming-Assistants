package main

type Robot struct {
    x, y int
    dir  int
    map_ map[string]bool
}

func Constructor(width, height int) Robot {
    return Robot{
        x:    0,
        y:    0,
        dir:  0,
        map_: make(map[string]bool),
    }
}

func (r *Robot) MoveTo(x, y int) {
    r.x = x
    r.y = y
}

func (r *Robot) MoveForward(k int) {
    for i := 0; i < k; i++ {
        nextX, nextY := r.x, r.y
        switch r.dir {
        case 0:
            nextY++
        case 1:
            nextX++
        case 2:
            nextY--
        case 3:
            nextX--
        }
        if nextX < 0 || nextX >= 1000 || nextY < 0 || nextY >= 1000 {
            return
        }
        r.x, r.y = nextX, nextY
    }
}

func (r *Robot) TurnLeft() {
    r.dir = (r.dir + 3) % 4
}

func (r *Robot) GetPosition() []int {
    return []int{r.x, r.y}
}

func (r *Robot) GetDirection() int {
    return r.dir
}