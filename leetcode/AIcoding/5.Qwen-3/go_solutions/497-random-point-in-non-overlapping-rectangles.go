package main

type Solution struct {
    rects [][]int
    areas []int
}

func Constructor(rects [][]int) Solution {
    s := Solution{rects: rects}
    s.areas = make([]int, len(rects))
    for i, r := range rects {
        width := r[2] - r[0] + 1
        height := r[3] - r[1] + 1
        s.areas[i] = width * height
    }
    return s
}

func (this *Solution) Pick() []int {
    total := 0
    for _, a := range this.areas {
        total += a
    }
    randNum := rand.Intn(total)
    for i, r := range this.rects {
        if randNum < this.areas[i] {
            x := r[0] + rand.Intn(r[2]-r[0]+1)
            y := r[1] + rand.Intn(r[3]-r[1]+1)
            return []int{x, y}
        }
        randNum -= this.areas[i]
    }
    return []int{}
}