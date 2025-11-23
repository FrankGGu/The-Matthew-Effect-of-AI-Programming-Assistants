import (
	"math/rand"
	"sort"
)

type Solution struct {
	rects [][]int
	prefix []int
}

func Constructor(rects [][]int) Solution {
	prefix := make([]int, len(rects)+1)
	for i := 0; i < len(rects); i++ {
		x1, y1, x2, y2 := rects[i][0], rects[i][1], rects[i][2], rects[i][3]
		area := (x2 - x1 + 1) * (y2 - y1 + 1)
		prefix[i+1] = prefix[i] + area
	}
	return Solution{rects, prefix}
}

func (this *Solution) Pick() []int {
	total := this.prefix[len(this.prefix)-1]
	r := rand.Intn(total)
	idx := sort.Search(len(this.prefix), func(i int) bool { return this.prefix[i] > r }) - 1
	rect := this.rects[idx]
	x1, y1, x2, y2 := rect[0], rect[1], rect[2], rect[3]
	x := x1 + rand.Intn(x2-x1+1)
	y := y1 + rand.Intn(y2-y1+1)
	return []int{x, y}
}