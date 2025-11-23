type Robot struct {
    width, height, x, y int
    dir                 []string
    curDir              int
    perimeter           int
}

func Constructor(width int, height int) Robot {
    dir := []string{"East", "North", "West", "South"}
    perimeter := 2 * (width + height - 2)
    return Robot{width, height, 0, 0, dir, 0, perimeter}
}

func (this *Robot) Step(num int) {
    if num == 0 {
        return
    }
    num %= this.perimeter
    if num == 0 {
        num = this.perimeter
    }
    for num > 0 {
        switch this.dir[this.curDir] {
        case "East":
            steps := min(num, this.width-1-this.x)
            this.x += steps
            if this.x == this.width-1 {
                this.curDir = (this.curDir + 1) % 4
            }
            num -= steps
        case "North":
            steps := min(num, this.height-1-this.y)
            this.y += steps
            if this.y == this.height-1 {
                this.curDir = (this.curDir + 1) % 4
            }
            num -= steps
        case "West":
            steps := min(num, this.x)
            this.x -= steps
            if this.x == 0 {
                this.curDir = (this.curDir + 1) % 4
            }
            num -= steps
        case "South":
            steps := min(num, this.y)
            this.y -= steps
            if this.y == 0 {
                this.curDir = (this.curDir + 1) % 4
            }
            num -= steps
        }
    }
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func (this *Robot) GetPos() []int {
    return []int{this.x, this.y}
}

func (this *Robot) GetDir() string {
    if this.x == 0 && this.y == 0 && this.curDir != 3 {
        return "South"
    }
    return this.dir[this.curDir]
}