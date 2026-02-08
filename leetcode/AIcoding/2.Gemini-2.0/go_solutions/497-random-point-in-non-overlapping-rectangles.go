import (
	"math/rand"
	"time"
)

type Solution struct {
	rects [][]int
	sums  []int
	total int
}

func Constructor(rects [][]int) Solution {
	sums := make([]int, len(rects))
	total := 0
	for i, rect := range rects {
		total += (rect[2] - rect[0] + 1) * (rect[3] - rect[1] + 1)
		sums[i] = total
	}
	rand.Seed(time.Now().UnixNano())
	return Solution{rects: rects, sums: sums, total: total}
}

func (this *Solution) Pick() []int {
	randNum := rand.Intn(this.total) + 1
	left, right := 0, len(this.sums)-1
	idx := 0
	for left <= right {
		mid := left + (right-left)/2
		if this.sums[mid] < randNum {
			left = mid + 1
		} else {
			idx = mid
			right = mid - 1
		}
	}
	rect := this.rects[idx]
	width := rect[2] - rect[0] + 1
	height := rect[3] - rect[1] + 1
	x := rect[0] + rand.Intn(width)
	y := rect[1] + rand.Intn(height)
	return []int{x, y}
}