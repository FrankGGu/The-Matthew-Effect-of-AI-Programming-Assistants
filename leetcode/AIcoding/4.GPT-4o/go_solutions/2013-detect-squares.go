type DetectSquares struct {
    points map[[2]int]int
}

func Constructor() DetectSquares {
    return DetectSquares{points: make(map[[2]int]int)}
}

func (this *DetectSquares) Add(point []int) {
    p := [2]int{point[0], point[1]}
    this.points[p]++
}

func (this *DetectSquares) Count(point []int) int {
    count := 0
    p := [2]int{point[0], point[1]}
    for k, v := range this.points {
        if k[0] != p[0] && abs(k[0]-p[0]) == abs(k[1]-p[1]) {
            count += v * this.points[[2]int{p[0], k[1]}] * this.points[[2]int{k[0], p[1]}]
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