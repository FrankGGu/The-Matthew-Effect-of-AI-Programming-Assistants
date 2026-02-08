type DetectSquares struct {
    points map[[2]int]int
}

func Constructor() DetectSquares {
    return DetectSquares{
        points: make(map[[2]int]int),
    }
}

func (this *DetectSquares) Add(point []int) {
    p := [2]int{point[0], point[1]}
    this.points[p]++
}

func (this *DetectSquares) Count(point []int) int {
    x, y := point[0], point[1]
    count := 0
    for p, cnt := range this.points {
        x1, y1 := p[0], p[1]
        if x1 != x && y1 != y && abs(x1-x) == abs(y1-y) {
            p2 := [2]int{x1, y}
            p3 := [2]int{x, y1}
            if cnt2, ok := this.points[p2]; ok {
                if cnt3, ok := this.points[p3]; ok {
                    count += cnt * cnt2 * cnt3
                }
            }
        }
    }
    return count
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}