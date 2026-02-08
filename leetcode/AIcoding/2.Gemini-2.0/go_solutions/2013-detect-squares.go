type DetectSquares struct {
    points map[[2]int]int
}

func Constructor() DetectSquares {
    return DetectSquares{
        points: make(map[[2]int]int),
    }
}

func (this *DetectSquares) Add(point []int)  {
    p := [2]int{point[0], point[1]}
    this.points[p]++
}

func (this *DetectSquares) Count(point []int) int {
    x, y := point[0], point[1]
    count := 0
    for p, c := range this.points {
        px, py := p[0], p[1]
        if px == x || py == y || px == x + (py-y) || px == x - (py-y){
            if abs(px-x) == abs(py-y) && px != x {
                count += this.points[[2]int{x, py}] * this.points[[2]int{px, y}] * c
            }
        }
    }
    return count
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}