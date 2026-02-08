type Robot struct {
    width, height int
    x, y int
    dir int
    dirs []string
}

func Constructor(width int, height int) Robot {
    return Robot{
        width: width,
        height: height,
        x: 0,
        y: 0,
        dir: 0,
        dirs: []string{"East", "North", "West", "South"},
    }
}

func (this *Robot) Step(num int)  {
    w := this.width
    h := this.height
    perimeter := 2 * (w + h - 2)
    num %= perimeter

    for num > 0 {
        if this.dir == 0 {
            if this.x + num < w {
                this.x += num
                num = 0
            } else {
                num -= (w - 1 - this.x)
                this.x = w - 1
                this.dir = 1
            }
        } else if this.dir == 1 {
            if this.y + num < h {
                this.y += num
                num = 0
            } else {
                num -= (h - 1 - this.y)
                this.y = h - 1
                this.dir = 2
            }
        } else if this.dir == 2 {
            if this.x - num >= 0 {
                this.x -= num
                num = 0
            } else {
                num -= this.x
                this.x = 0
                this.dir = 3
            }
        } else {
            if this.y - num >= 0 {
                this.y -= num
                num = 0
            } else {
                num -= this.y
                this.y = 0
                this.dir = 0
            }
        }
    }
}

func (this *Robot) GetPos() []int {
    return []int{this.x, this.y}
}

func (this *Robot) GetDir() string {
    return this.dirs[this.dir]
}