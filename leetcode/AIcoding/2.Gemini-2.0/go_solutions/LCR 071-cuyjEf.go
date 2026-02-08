import (
	"math/rand"
	"time"
)

type Solution struct {
	prefixSums []int
	totalSum   int
}

func Constructor(w []int) Solution {
	rand.Seed(time.Now().UnixNano())
	prefixSums := make([]int, len(w))
	totalSum := 0
	for i, weight := range w {
		totalSum += weight
		prefixSums[i] = totalSum
	}
	return Solution{prefixSums: prefixSums, totalSum: totalSum}
}

func (this *Solution) PickIndex() int {
	target := rand.Intn(this.totalSum) + 1
	low, high := 0, len(this.prefixSums)-1
	for low <= high {
		mid := low + (high-low)/2
		if this.prefixSums[mid] < target {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return low
}