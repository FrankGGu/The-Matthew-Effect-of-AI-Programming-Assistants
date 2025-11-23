package main

type DetectSquares struct {
    pointsMap map[[2]int]int
}

func Constructor() DetectSquares {
    return DetectSquares{
        pointsMap: make(map[[2]int]int),
    }
}

func (this *DetectSquares) Add(point []int) {
    p := [2]int{point[0], point[1]}
    this.pointsMap[p]++
}

func (this *DetectSquares) Count(point []int) int {
    x, y := point[0], point[1]
    res := 0
    for p := range this.pointsMap {
        px, py := p[0], p[1]
        if px == x || py == y {
            continue
        }
        if this.pointsMap[[2]int{px, y}] > 0 && this.pointsMap[[2]int{x, py}] > 0 {
            res += this.pointsMap[p] * this.pointsMap[[2]int{px, y}] * this.pointsMap[[2]int{x, py}]
        }
    }
    return res
}